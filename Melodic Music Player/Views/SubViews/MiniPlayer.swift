//
//  MPlayer.swift
//  Melodic Music Player
//
//  Created by Anton Rasen on 19.11.2024.
//

import SwiftUI

struct MiniPlayer: View {
    var body: some View {
        HStack{
            Color.cyan
                .frame(width: 50,height: 50)
                .cornerRadius(10)
            
            VStack{
                Text("Название")
                    .firstFont()
                Text("Исполнитель")
                    .secondFont()
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "play.fill")
                    .foregroundStyle(.white)
                    .font(.title)
            }
            
        }
        .padding()
        .padding(.trailing)
        .padding(.leading, 5)
        .background(.black.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
    }
}

#Preview {
    MiniPlayer()
}
