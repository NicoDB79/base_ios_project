//
//  TextFieldView.swift
//  BaseProject
//
//  Created by Nicola De Bei on 19/12/22.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .alphabet
    var backgroundColor: Color = Asset.Colors.backgroundSecondary.swiftUIColor
    
    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .disableAutocorrection(true)
            .font(FontFamily.NotoSans.condensedBold.swiftUIFont(size: 16))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Asset.Colors.buttonBorder.swiftUIColor,
                            lineWidth: 2)
            )
            .background(backgroundColor)
            .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        return MainBackgroundView {
            TextFieldView(placeholder: .constant("Placeholder"),
                          text: .constant("333445566"))
            .padding()
        }
        
    }
}
