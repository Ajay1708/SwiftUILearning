//
//  AppStorageDemo.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 27/09/24.
//

import SwiftUI

struct AppStorageDemo: View {
    @AppStorage("userName") var userName: String = ""
    var body: some View {
        VStack {
            Text(userName)
            
            Button {
                userName = "Ajay"
            } label: {
                Text("Action")
            }

        }
    }
}

#Preview {
    AppStorageDemo()
}
