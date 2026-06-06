//
//  CardView.swift
//  BaseProject
//
//  Created by Nicola De Bei on 19/01/23.
//

import SwiftUI

struct CardView<Content>: View where Content: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body : some View {
        content
        .background(Asset.Colors.backgroundSecondary.swiftUIColor)
        .cornerRadius(12)

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView {
            Text("Hello")
        }
        .frame(height: 200)
    }
}
