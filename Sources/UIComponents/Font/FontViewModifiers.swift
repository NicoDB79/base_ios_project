//
//  FontViewModifiers.swift
//  BaseProject
//
//  Created by Nicola De Bei on 15/12/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct header3Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(
                FontFamily.NotoSans.condensedBold.swiftUIFont(size: 25)
            )
    }
}

struct NotoSansCondensedBold20Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(
                FontFamily.NotoSans.condensedBold.swiftUIFont(size: 20)
            )
    }
}

struct bodyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(
                FontFamily.NotoSans.condensedMedium.swiftUIFont(size: 16)
            )
    }
}

struct header4Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(
                FontFamily.NotoSans.condensedBold.swiftUIFont(size: 20)
            )
    }
}

struct bodyBoldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(
                FontFamily.NotoSans.condensedBold.swiftUIFont(size: 16)
            )
    }
}

struct header2Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(
                FontFamily.NotoSans.condensedBold.swiftUIFont(size: 31)
            )
    }
}

struct NotoSansCondensedBold57Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(
                FontFamily.NotoSans.condensedBold.swiftUIFont(size: 57)
            )
    }
}

struct NotoSansCondensedBold103Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(
                FontFamily.NotoSans.condensedBold.swiftUIFont(size: 103)
            )
    }
}

struct NotoSansRegular13Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(
                FontFamily.NotoSans.regular.swiftUIFont(size: 13)
            )
    }
}

extension Text {
    func header3() -> some View {
        modifier(header3Modifier())
    }
    func notoSansCondensedBold20() -> some View {
        modifier(NotoSansCondensedBold20Modifier())
    }
    
    func body() -> some View {
        modifier(bodyModifier())
    }
    
    func header4() -> some View {
        modifier(header4Modifier())
    }
    
    func bodyBold() -> some View {
        modifier(bodyBoldModifier())
    }
    
    func header2() -> some View {
        modifier(header2Modifier())
    }
    
    func notoSansCondensedBold103() -> some View {
        modifier(NotoSansCondensedBold103Modifier())
    }
    
    func notoSansRegular13() -> some View {
        modifier(NotoSansRegular13Modifier())
    }
    
    func notoSansCondensedBold57() -> some View {
        modifier(NotoSansCondensedBold57Modifier())
    }
}
