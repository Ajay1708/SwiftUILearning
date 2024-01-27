//
//  ButtonStyleBootCamp.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 27/01/24.
//

import SwiftUI

struct ButtonStyleDemo: View {
    // The default style of button is borderless
    var body: some View {
        VStack(spacing: 20) {
            customButton(text: "Default Style(i.e BorderLess)") {
                
            }
            
            customButton(text: "Plain") {
                
            }
            .buttonStyle(.plain)
            
            customButton(text: "Bordered") {
                
            }
            .buttonStyle(.bordered)
            
            customButton(text: "BorderLess") {
                
            }
            .buttonStyle(.borderless)
            
            customButton(text: "BorderProminent") {
                
            }
            .buttonStyle(.borderedProminent)
            
            customButton(text: "Automatic") {
                
            }
            .buttonStyle(.automatic)
            
            customButton(text: "Press Style") {
                
            }
            .withPressableStyle()
        }
        .padding()
    }
}

#Preview {
    ButtonStyleDemo()
}
