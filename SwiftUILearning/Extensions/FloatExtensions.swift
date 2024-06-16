//
//  FloatExtensions.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 19/05/24.
//

import Foundation
extension Float {
    func roundOff(fractionalpartCount: Int? = nil) -> String {
        let fractionalpartCount = fractionalpartCount != nil ? fractionalpartCount ?? 0 : getFractionalpartCount()
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.\(fractionalpartCount)f", self)
    }
    
    func toString() -> String{
        String(format: "%.0f", self)
    }
    
    func getFractionalpartCount() -> Int {
        let fractionalpart = String(self).split(separator: ".")[1]
        return fractionalpart == "0" ? 0 : fractionalpart.count
    }
    
    var progressPercentage: String {
        self.formatted(.percent.precision(.fractionLength(0)))
    }
}
