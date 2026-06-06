//
//  BlinkViewModifiers.swift
//  BaseProject
//
//  Created by Nicola De Bei on 27/02/23.
//

import SwiftUI

struct BlinkViewModifiers: ViewModifier {
    
    let duration: Double
    let active: Bool
    @State private var blinking: Bool = false
    
    func body(content: Content) -> some View {
        if active {
            content
                .opacity(blinking ? 0 : 1)
                .scaleEffect(blinking ? 0.8 : 1.0)
                .animation(.easeOut(duration: duration).repeatForever(), value: blinking)
                .onAppear {
                    blinking = true
                }
        } else {
            content
        }
    }
}

extension View {
    func blinking(duration: Double = 0.75, active: Bool) -> some View {
        modifier(BlinkViewModifiers(duration: duration, active: active))
    }
}
