//
//  Background.swift
//  Melodic Music Player
//
//  Created by Anton Rasen on 15.11.2024.
//

import SwiftUI

struct Background: View {
    var body: some View {
        LinearGradient(
            colors: [.BGB ,.BGT],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
        
    }
}


#Preview {
    Background()
}
