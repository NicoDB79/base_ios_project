//
//  SecondaryBackgroundView.swift
//  BaseProject
//
//  Created by Nicola De Bei on 08/03/23.
//

import SwiftUI

struct SecondaryBackgroundView<Content>: View where Content: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body : some View {
        ZStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Asset.Colors.backgroundSecondary.swiftUIColor)
    }
}

struct SecondaryBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryBackgroundView {
            Text("Hello!")
        }
    }
}
