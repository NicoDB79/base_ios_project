//
//  Utils.swift
//  PopupView
//
//  Created by Alisa Mylnikova on 01.06.2022.
//  Copyright © 2022 Exyte. All rights reserved.
//

import SwiftUI
import Combine

final class DispatchWorkHolder {
    var work: DispatchWorkItem?
}

final class ClassReference<T> {
    var value: T

    init(_ value: T) {
        self.value = value
    }
}

extension View {

    @ViewBuilder
    func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { value in
                onChange(value)
            }
        }
    }
}

extension View {
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }

    @ViewBuilder
    func addTapIfNotTV(if condition: Bool, onTap: @escaping ()->()) -> some View {
#if os(tvOS)
        self
#else
        if condition {
            self.gesture(
                TapGesture().onEnded {
                    onTap()
                }
            )
        } else {
            self
        }
#endif
    }
}

// MARK: - FrameGetter

struct FrameGetter: ViewModifier {

    @Binding var frame: CGRect

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy -> AnyView in
                    DispatchQueue.main.async {
                        let rect = proxy.frame(in: .global)
                        // This avoids an infinite layout loop
                        if rect.integral != self.frame.integral {
                            self.frame = rect
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
    }
}

extension View {
    public func frameGetter(_ frame: Binding<CGRect>) -> some View {
        modifier(FrameGetter(frame: frame))
    }
}

// MARK: - AnimationCompletionObserver

struct AnimationCompletionObserverModifier<Value>: @preconcurrency AnimatableModifier where Value: VectorArithmetic, Value: Comparable {

    var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }

    private var targetValue: Value
    private var completion: @Sendable () -> Void

    init(observedValue: Value, completion: @Sendable @escaping () -> Void) {
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }

    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }
        /// Defer to the next runloop to avoid "Modifying state during view update" errors.
        let completion = completion
        Task { completion() }
    }

    func body(content: Content) -> some View {
        return content
    }
}

struct AnimatableModifierDouble: AnimatableModifier {

    var targetValue: Double
    static var done = false

    // SwiftUI gradually varies it from old value to the new value
    var animatableData: Double {
        didSet {
            checkIfFinished()
        }
    }
    var completion: () -> ()

    // Re-created every time the control argument changes
    init(bindedValue: Double, completion: @escaping () -> ()) {
        self.completion = completion

        // Set animatableData to the new value. But SwiftUI again directly
        // and gradually varies the value while the body
        // is being called to animate. Following line serves the purpose of
        // associating the extenal argument with the animatableData.
        self.animatableData = bindedValue
        targetValue = bindedValue
        AnimatableModifierDouble.done = false
    }

    func checkIfFinished() -> () {
        if AnimatableModifierDouble.done { return }
        let delta = 0.1
        if animatableData > targetValue - delta &&
            animatableData < targetValue + delta {
            //print("check", animatableData, targetValue)
            AnimatableModifierDouble.done = true
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {

    func onAnimationCompleted(for value: Double, completion: @escaping () -> Void) -> some View {
        modifier(AnimatableModifierDouble(bindedValue: value, completion: completion))
    }
}

// MARK: - SafeAreaInsets

#if os(iOS)

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap {
                $0 as? UIWindowScene
            }
            .flatMap {
                $0.windows
            }
            .first {
                $0.isKeyWindow
            }
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

#else

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        EdgeInsets()
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

#endif

// MARK: - TransparentNonAnimatingFullScreenCover

#if os(iOS)

extension View {

    func transparentNonAnimatingFullScreenCover<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
        modifier(TransparentNonAnimatableFullScreenModifier(isPresented: isPresented, fullScreenContent: content))
    }
}

private struct TransparentNonAnimatableFullScreenModifier<FullScreenContent: View>: ViewModifier {

    @Binding var isPresented: Bool
    let fullScreenContent: () -> (FullScreenContent)

    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented) { isPresented in
                UIView.setAnimationsEnabled(false)
            }
            .fullScreenCover(isPresented: $isPresented, content: {
                ZStack {
                    fullScreenContent()
                }
                .background(FullScreenCoverBackgroundRemovalView())
                .onAppear {
                    if !UIView.areAnimationsEnabled {
                        UIView.setAnimationsEnabled(true)
                    }
                }
                .onDisappear {
                    if !UIView.areAnimationsEnabled {
                        UIView.setAnimationsEnabled(true)
                    }
                }
            })
    }
}

private struct FullScreenCoverBackgroundRemovalView: UIViewRepresentable {

    private class BackgroundRemovalView: UIView {

        override func didMoveToWindow() {
            super.didMoveToWindow()

            superview?.superview?.backgroundColor = .clear
        }

    }

    func makeUIView(context: Context) -> UIView {
        return BackgroundRemovalView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

}

#endif

// MARK: - KeyboardHeightHelper

#if os(iOS)

class KeyboardHeightHelper: ObservableObject {

    @Published var keyboardHeight: CGFloat = 0
    @Published var keyboardDisplayed: Bool = false

    init() {
        self.listenForKeyboardNotifications()
    }

    private func listenForKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            guard let userInfo = notification.userInfo,
                  let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

            self.keyboardHeight = keyboardRect.height
            self.keyboardDisplayed = true
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            self.keyboardHeight = 0
            self.keyboardDisplayed = false
        }
    }
}

#else

class KeyboardHeightHelper: ObservableObject {

    @Published var keyboardHeight: CGFloat = 0
    @Published var keyboardDisplayed: Bool = false
}

#endif
