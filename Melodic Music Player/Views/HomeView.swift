
import SwiftUI

struct HomeView: View {
    @State private var viewModel = ViewModelPlayer()
    @State private var isShow = false
    @Namespace private var animationTrackDescription
    var frameAlbumCover: CGFloat {
        isShow ? 330 : 50
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                VStack{
                   
                        // Список композиций
                        List(viewModel.melodies) { melody in
                            СustomСell(melody: melody, formatted: viewModel.formatted)
                                .onTapGesture {
                                    viewModel.play(melody: melody )
                                }
                        }
                        .listStyle(.plain)
                                         Spacer()
                    // Player
                    if viewModel.currentMelody != nil {
                        Player()
                        .frame(height: isShow ? UIScreen.main.bounds.height + 250 : 70)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                self.isShow.toggle()
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    FileManager(melodies: $viewModel.melodies)
                }
            }
            
            
       }
     }
    @ViewBuilder
    private func TrackDescription() -> some View {
        VStack(alignment: isShow ? .center : .leading){
            if let currentMelody = viewModel.currentMelody {
                Text(currentMelody.name)
                    .firstFont()
                Text(currentMelody.artist ?? "Неизвестный артист")
                    .secondFont()
            }
        }
        .matchedGeometryEffect(id: "animationDescription", in: animationTrackDescription)
    }
    
    @ViewBuilder
    private func Player() -> some View {
        VStack{
            HStack{
                if let data = viewModel.currentMelody?.image, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: frameAlbumCover, height: frameAlbumCover)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    ZStack{
                        Color.gray
                            .frame(width: frameAlbumCover, height: frameAlbumCover)
                        
                        Image(systemName: "music.quarternote.3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 32)
                            .foregroundStyle(.white)
                    }
                    .cornerRadius(10)
                }
                
                if !isShow {
                    TrackDescription()
                   
                    Spacer()
                    
                    CostomButton(label: viewModel.isPlaying ? "pause.fill" : "play.fill" , size: .title) {
                        viewModel.playPause()
                    }
                }
            }
            .padding()
            .background(isShow ? .clear : .black.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            
            if isShow {
                
                TrackDescription()

                VStack{
                    HStack{
                        Text("00:00")
                        Spacer()
                        Text("00:10")
                    }
                    .secondFont()
                    .padding()
                    
                    Divider()
                    HStack(spacing: 50){
                        CostomButton(label: "backward.end.fill", size: .system(size: 25)) {
                            
                        }
                        CostomButton(label: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill", size: .system(size: 50)) {
                            viewModel.playPause()
                        }
                        CostomButton(label: "forward.end.fill", size: .system(size: 25)) {
                            
                        }
                    }
                }
                .padding(40)
            }
        }
    }
    
    private func CostomButton(label: String, size: Font, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: label)
                .foregroundStyle(.white)
                .font(size)
        }
    }
}

#Preview {
    HomeView()
}




