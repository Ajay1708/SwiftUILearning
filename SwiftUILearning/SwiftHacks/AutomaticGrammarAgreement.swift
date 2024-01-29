//
//  AutomaticGrammarAgreement.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 29/01/24.
//

import SwiftUI

struct AutomaticGrammarAgreement: View {
    @State private var count = 1
    var body: some View {
        VStack(spacing: 20) {
            Button("Add") {
                count += 1
            }
            .bold()
            Button("Remove") {
                if count != 0 {
                    count -= 1
                }
            }
            .bold()
            .padding(.bottom, 30)
            Text("^[\(count) Person](inflect: true)")
            Text("^[\(count) Apple](inflect: true)")
            Text("^[\(count) Week](inflect: true)")
        }
        .font(.title)
    }
}

#Preview {
    AutomaticGrammarAgreement()
}
