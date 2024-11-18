

import SwiftUI
import AVFoundation

struct FileManager: View {
    @Binding var melodies: [Model]
    @State var openFile = false
    
    var body: some View {
        VStack(){
            Button {
                self.openFile.toggle()
            }    label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
            }
        }
        .fileImporter( isPresented: $openFile, allowedContentTypes: [.audio], allowsMultipleSelection: false, onCompletion: {
            result in
            do{
                let urls = try result.get()
                guard let url = urls.first else { return }
                
                let melodyData = try Data(contentsOf: url)
                let melodyAsset = AVURLAsset(url: url)
                var melody = Model(name: url.lastPathComponent, data: melodyData)
                
                let metadata = melodyAsset.metadata
                for item in metadata {
                    guard let key = item.commonKey?.rawValue, let value = item.value else { continue }
                    
                    switch key {
                    case AVMetadataKey.commonKeyArtist.rawValue:
                        melody.artist = value as? String
                    case AVMetadataKey.commonKeyArtwork.rawValue:
                        melody.image = value as? Data
                    case AVMetadataKey.commonKeyTitle.rawValue:
                        melody.name = value as? String ?? melody.name
                    default:
                        break
                    }
                }
                melody.duration = CMTimeGetSeconds(melodyAsset.duration)
                
                if !self.melodies.contains(where: {$0.name == melody.name }) {
                    DispatchQueue.main.async{
                        self.melodies.append(melody)
                    }
                }
            }
            catch{
                print("error reading file \(error.localizedDescription)")
            }
        })
    }
}



