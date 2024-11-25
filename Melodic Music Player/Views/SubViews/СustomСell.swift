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
            CoverView(cover: melody.image, size: 60)
      
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


