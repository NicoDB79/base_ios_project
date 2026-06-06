//
//  CellView.swift
//  BaseProject
//
//  Created by Nicola De Bei on 27/12/22.
//

import SwiftUI

struct CellView<Content>: View where Content: View {
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body : some View {
        content
        .background(Asset.Colors.backgroundSecondary.swiftUIColor)
        .cornerRadius(12)
        .listRowBackground(
            RoundedRectangle(cornerRadius: 12)
                .background(.clear)
                .foregroundColor(Asset.Colors.backgroundSecondary.swiftUIColor)
                .padding(
                    EdgeInsets(
                        top: 8,
                        leading: 15,
                        bottom: 8,
                        trailing: 15
                    )
                )
                .shadow(color: Asset.Colors.shadowColor.swiftUIColor, radius: 20)
        )
        .contentShape(Rectangle())

    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView {
            Text("Hello")
        }
        .frame(height: 200)
    }
}
