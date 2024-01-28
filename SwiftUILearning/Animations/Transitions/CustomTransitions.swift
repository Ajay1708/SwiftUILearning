//
//  CustomTransitions.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 28/01/24.
//

import Foundation
import SwiftUI

struct RotateViewModifier: ViewModifier {
    let rotation: Double
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(x: rotation != 0 ? UIScreen.main.bounds.size.width : 0, y: rotation != 0 ? UIScreen.main.bounds.size.height : 0)
    }
}
extension AnyTransition {
    static var rotation: AnyTransition {
        modifier(active: RotateViewModifier(rotation: 360), identity: RotateViewModifier(rotation: 0))
    }
    
    static func rotation(amount: Double) -> AnyTransition {
        modifier(active: RotateViewModifier(rotation: amount), identity: RotateViewModifier(rotation: 0))
    }
    
    static var rotateOn: AnyTransition {
        asymmetric(insertion: rotation, removal: .move(edge: .leading))
    }
}
