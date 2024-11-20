
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
                    VStack{
                        HStack{
                            Color.cyan
                                .frame(width: frameAlbumCover,height: frameAlbumCover)
                                .cornerRadius(10)
                            if !isShow {
                                VStack(alignment: .leading){
                                    Text("Название")
                                        .firstFont()
                                    Text("Исполнитель")
                                        .secondFont()
                                }
                                .matchedGeometryEffect(id: "animationDescription", in: animationTrackDescription)
                                
                                Spacer()
                               
                                CostomButton(label: "play.fill", size: .title) {
                                    
                                }
                            }
                        }
                        .padding()
                        .background(isShow ? .clear : .black.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                        
                        if isShow {
                            VStack{
                                Text("Название")
                                    .firstFont()
                                Text("Исполнитель")
                                    .secondFont()
                            }
                            .matchedGeometryEffect(id: "animationDescription", in: animationTrackDescription)
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
                                    CostomButton(label: "play.circle.fill", size: .system(size: 50)) {
                                        
                                    }
                                    CostomButton(label: "forward.end.fill", size: .system(size: 25)) {
                                        
                                    }
 }
                            }
                            .padding(40)
                        }
                    }
                    .frame(height: isShow ? UIScreen.main.bounds.height + 250 : 70)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            self.isShow.toggle()
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




