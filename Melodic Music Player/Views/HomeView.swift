
import SwiftUI

struct HomeView: View {
    @State var viewModel = ViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                // Список композиций
                List(viewModel.melodies) { song in
                    СustomСell(melody: song, formatted: viewModel.formatted)
                }
                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    FileManager(melodies: $viewModel.melodies)
              }
            }
            
        }
       
    }
}

#Preview {
    HomeView()
}


