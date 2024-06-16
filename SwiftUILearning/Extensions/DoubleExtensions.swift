//
//  DoubleExtensions.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 01/06/24.
//

import Foundation

extension Double {
    func formatTime() -> String {
        let hours = Int(self / 3600)
        let minutes = Int((self.truncatingRemainder(dividingBy: 3600)) / 60)
        let remainingSeconds = Int(self.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
        } else {
            return String(format: "%02d:%02d", minutes, remainingSeconds)
        }
    }
}
