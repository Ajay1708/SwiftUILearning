//
//  CustomProgressViewModel.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 26/05/24.
//

import SwiftUI

class LinearProgressViewModel: ObservableObject {
    @Published var currentProgressValue: Double = 0.0
    
    private var timer: Timer?
    private let durationInSeconds: Double
    private let reverse: Bool
    private let timeInterval: Double = 0.01 // Update every 0.01 seconds
    
    /*
     The updationValue determines how much the progress should increase or decrease at each interval. This ensures that the progress value reaches 1.0(for forward) or 0.0(for reverse) at the end of the specified duration.
     Ex: If the duration is 5 seconds and the interval is 0.01 second, the updationValue will be 0.01 / 5 = 0.002.
     This means the progress will either increase or decrease by 0.002 every 0.01 second.
     Over 5 seconds, the progress will increase by 0.002 * (5 / 0.01) = 1.0, reaching 100%. --> Forward progress
     */
    lazy var updationValue: CGFloat = {
        timeInterval / durationInSeconds
    }()
    
    init(
        durationInSeconds: Double,
        initialProgressValue: Double = 0.0,
        reverse: Bool = false
    ) {
        self.durationInSeconds = durationInSeconds
        self.currentProgressValue = initialProgressValue
        self.reverse = reverse
        if reverse {
            self.currentProgressValue = 1.0
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func initiateTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] timer in
            guard let self else {return}
            DispatchQueue.main.async {
                if self.reverse {
                    self.decrementProgess()
                } else {
                    self.incrementProgress()
                }
            }
        })
        
        guard let timer else {return}
        RunLoop.main.add(timer, forMode: .common)
    }
    
    func incrementProgress() {
        if self.currentProgressValue < 1.0 {
            // Ensure the progress does not exceed 1.0
            self.currentProgressValue = min(self.currentProgressValue + updationValue, 1.0)
        } else {
            // Invalidate the timer when progress reaches 1.0
            timer?.invalidate()
        }
    }
    
    func decrementProgess() {
        if self.currentProgressValue > 0.0 {
            // Ensure the progress does not subceed 0.0
            self.currentProgressValue = max(self.currentProgressValue - updationValue, 0.0)
        } else {
            // Invalidate the timer when progress reaches 0.0
            timer?.invalidate()
        }
    }
}
