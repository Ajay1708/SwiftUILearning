//
//  SwiftUILearningApp.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 26/01/24.
//

import SwiftUI

@main
struct SwiftUILearningApp: App {
    var body: some Scene {
        WindowGroup {
            LinearProgressViewDemo(
                progressColor: Color.purple,
                trackColor: Color.gray.opacity(0.5),
                height: 10,
                viewModel: LinearProgressViewModel(durationInSeconds: 10, initialProgressValue: 0.25, reverse: true)
            )
        }
    }
}
