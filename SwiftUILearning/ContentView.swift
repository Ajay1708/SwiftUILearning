//
//  ContentView.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 26/01/24.
//

import SwiftUI

struct ContentView: View {
    //TODO: sdfasdfsd
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            customButton(action: {
                
            })
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
