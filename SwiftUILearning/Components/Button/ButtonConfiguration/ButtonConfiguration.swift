//
//  ButtonStyle.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 27/01/24.
//

import Foundation
import SwiftUI
struct DefaultButtonViewModifier: ViewModifier {
    let font: Font
    let backgroundColor: Color
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 10)
    }
}

extension View {
    func withDefaultButtonFormatting(font: Font = .title, backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(font: font, backgroundColor: backgroundColor))
    }
}


struct PressableButtonSyle: ButtonStyle {
    let font: Font
    let backgroundColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .withDefaultButtonFormatting(font: font, backgroundColor: backgroundColor)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ColoredButtonStyle: ButtonStyle {
    let transition: Transitions
    func makeBody(configuration: Configuration) -> some View {
        switch transition {
        case .Slide:
            configuration.label
                .foregroundStyle(.red)
        case .Scale:
            configuration.label
                .foregroundStyle(.blue)
        case .Opacity:
            configuration.label
                .foregroundStyle(.green)
        case .Move:
            configuration.label
                .foregroundStyle(.orange)
        case .Asymmetric:
            configuration.label
                .foregroundStyle(.black)
        }
        
    }
}

extension View {
    func withPressableStyle(font: Font = .title, backgroundColor: Color = .blue) -> some View {
        buttonStyle(PressableButtonSyle(font: font, backgroundColor: backgroundColor))
    }
    
    func withColorStyle(transition: Transitions) -> some View {
        buttonStyle(ColoredButtonStyle(transition: transition))
    }
}
