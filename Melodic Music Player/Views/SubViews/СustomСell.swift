//
//  СustomСell.swift
//  Melodic Music Player
//
//  Created by Anton Rasen on 15.11.2024.
//

import SwiftUI

struct СustomСell: View {
    var song: Model
    var body: some View {
        HStack {
            Color.cyan
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            VStack(alignment: .leading){
                Text(song.name)
                    .firstFont()
                Text(song.artist ?? "Неизвестен")
                    .secondFont()
            }
            Spacer()
            Text("0")
                .secondFont()
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}


