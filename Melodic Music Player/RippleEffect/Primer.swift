/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Examples for using and configuring the ripple shader as a layer effect.
*/

import SwiftUI

struct CView: View {
    @State private var counter: Int = 0
    @State private var origin: CGPoint = .zero
    
    var body: some View {
        Image("1")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .onTapGesture { location in
                origin = location
                counter += 1
            }
            .rippleEffect(at: origin, trigger: counter)
    }
}
#Preview {
    CView()
}
