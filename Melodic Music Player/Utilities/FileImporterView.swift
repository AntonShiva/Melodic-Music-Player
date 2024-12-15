

import SwiftUI
import AVFoundation

struct FileImporterView: View {
    @Binding var melodies: [Model]
    @State var openFile = false
   
    
    var body: some View {
        VStack {
            Button {
                self.openFile.toggle()
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.blue)
            }
            
        }
        .padding(.trailing, 10)
        .fileImporter(
            isPresented: $openFile,
            allowedContentTypes: [.audio],
            allowsMultipleSelection: false
        ) { result in
            Task {
                do {
                    let urls = try result.get()
                    guard let url = urls.first else { return }
                    // добавил возможност с реального телефона открывать файлы при помощи AccessingSecurityScopedResource
                    if url.startAccessingSecurityScopedResource(){
                        let melodyData = try Data(contentsOf: url)
                        let melodyAsset = AVURLAsset(url: url)
                        var melody = Model(name: url.lastPathComponent, data: melodyData)
                        
                        // Загружаем метаданные
                        let metadata = try await melodyAsset.load(.metadata)
                        for item in metadata {
                            guard let key = item.commonKey?.rawValue else { continue }
                            
                            switch key {
                            case AVMetadataKey.commonKeyArtist.rawValue:
                                melody.artist = try await item.load(.value) as? String
                            case AVMetadataKey.commonKeyArtwork.rawValue:
                                melody.image = try await item.load(.value) as? Data
                            case AVMetadataKey.commonKeyTitle.rawValue:
                                if let title = try await item.load(.value) as? String {
                                    melody.name = title
                                }
                            default:
                                break
                            }
                        }
                        
                        // Загружаем длительность
                        let duration = try await melodyAsset.load(.duration)
                        melody.duration = CMTimeGetSeconds(duration)
                        
                        // Добавляем мелодию, если её нет в списке
                        if !self.melodies.contains(where: { $0.name == melody.name }) {
                            DispatchQueue.main.async {
                                self.melodies.append(melody)
                            }
                        }
                        url.stopAccessingSecurityScopedResource()
                    }
                } catch {
                    print("Ошибка чтения файла: \(error.localizedDescription)")
                }
            }
        }
    }
}



