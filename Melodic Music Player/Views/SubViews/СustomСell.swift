//
//  СustomСell.swift
//  Melodic Music Player
//
//  Created by Anton Rasen on 15.11.2024.
//

import SwiftUI

struct СustomСell: View {
    var melody: Model
    let formatted: (TimeInterval) -> String
    var body: some View {
        HStack {
            if let data = melody.image, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                ZStack{
                    Color.gray
                        .frame(width: 60, height: 60)
                        
                    Image(systemName: "music.quarternote.3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 32)
                        .foregroundStyle(.white)
                }
                .cornerRadius(10)
            }
            VStack(alignment: .leading){
                Text(melody.name)
                    .firstFont()
                Text(melody.artist ?? "Неизвестен")
                    .secondFont()
            }
            Spacer()
            if let duration = melody.duration {
                Text(formatted(duration))
                    .secondFont()
            }
           
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}


