//
//  CoverView.swift
//  Melodic Music Player
//
//  Created by Anton Rasen on 25.11.2024.
//

import SwiftUI

struct CoverView: View {
    let cover: Data?
    let size: CGFloat
    
    var body: some View {
        if let data = cover, let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
            ZStack{
                Color.gray
                    .frame(width: size, height: size)
                    
                Image(systemName: "music.quarternote.3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 32)
                    .foregroundStyle(.white)
            }
            .cornerRadius(10)
        }

    }
}

#Preview {
    CoverView(cover: Data(), size: 150)
}
