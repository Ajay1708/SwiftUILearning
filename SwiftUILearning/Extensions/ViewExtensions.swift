//
//  ViewExtensions.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 26/01/24.
//

import Foundation
import SwiftUI
extension View {
    func withDefaultButtonFormatting(backgroundColor: Color) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}
