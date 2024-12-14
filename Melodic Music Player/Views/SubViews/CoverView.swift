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
    //Свойства для блестящей ряби
    @State private var counter: Int = 0
    @State private var origin: CGPoint = .zero
    
    var body: some View {
        if let data = cover, let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            // Эффект ряби
                    .rippleEffect(at: origin, trigger: counter)
                    .onTapGesture { location in
                        origin = location
                        counter += 1
                    }
        } else {
            ZStack{
                Color.gray
                    .frame(width: size, height: size)
                    
                Image(systemName: "music.note")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: size / 2)
                    .foregroundStyle(.white)
                    
            }
            .cornerRadius(10)
        }

    }
}

#Preview {
    CoverView(cover: Data(), size: 150)
}
