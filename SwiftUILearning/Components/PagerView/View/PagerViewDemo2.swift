//
//  PagerViewDemo2.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 02/06/24.
//

import SwiftUI

struct PagerViewDemo2: View {
    var body: some View {
        ZStack {
            Color(hex: "#272239").ignoresSafeArea(.all)
        }
        .toolbar(.hidden, for: .automatic)
    }
}

#Preview {
    PagerViewDemo2()
}
