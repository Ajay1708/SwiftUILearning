//
//  CustomProgressViewModel.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 26/05/24.
//

import SwiftUI

@MainActor
class LinearProgressViewModel: ObservableObject {
    @Published var currentProgressValue: Double = 0.0
    @Published var progressEnded: Bool = false
    @Published var progressCompletionTime: String = "00:00"
    @Published var showShimmer: Bool = false
    
    private var timer: Timer?
    private var durationInSeconds: Double
    private let initialProgressValue: Double
    private let reverse: Bool
    private let timeInterval: Double = 0.01 // Update every 1/100 of a second
    
    /*
     The updationValue determines how much the progress should increase or decrease at each interval. This ensures that the progress value reaches 1.0(for forward) or 0.0(for reverse) at the end of the specified duration.
     Ex: If the duration is 5 seconds and the interval is 0.01 second, the updationValue will be 0.01 / 5 = 0.002.
     This means the progress will either increase or decrease by 0.002 every 0.01 second.
     Over 5 seconds, the progress will increase by 0.002 * (5 / 0.01) = 1.0, reaching 100%. --> Forward progress
     */
    var updationValue: CGFloat = 0
    
    /// - Parameters:
    ///   - durationInSeconds: Show the progress for the given duration
    ///   - initialProgressValue: Start the progress with the initialProgressValue. The initialProgress should be in the range of 0 ... 1
    ///   - reverse: This boolean check allows us to reverse the progress starting from 1 - initialProgressValue
    init(
        durationInSeconds: Double,
        initialProgressValue: Double = 0.0,
        reverse: Bool = false
    ) {
        self.durationInSeconds = durationInSeconds
        self.initialProgressValue = initialProgressValue
        self.reverse = reverse
        setupProgressValue()
    }
    
    deinit {
        print("\(Self.self) is de-initialised")
    }
    
    /// Updates the duration to run ProgressView
    func updateDuration(_ durationInSeconds: Double) {
        self.durationInSeconds = durationInSeconds
        startTimer(with: .seconds(2))
    }
    
    /// Before initiating Timer we should invalidate the existing Timer if exists
    func scheduleTimer() {
        guard timer == nil else {
            invalidateTimer()
            return
        }
        
        showShimmer = false
        updationValue = timeInterval / durationInSeconds
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] timer in
            guard let self else {return}
            DispatchQueue.main.async {
                self.handleProgress()
            }
        })
        
        guard let timer else {return}
        RunLoop.main.add(timer, forMode: .common)
    }
    
    /// This method either `Increment or Decrement the progressView` and `updates the progressCompletionTime` for `every 0.01 second`
    private func handleProgress() {
        if reverse {
            decrementProgess()
        } else {
            incrementProgress()
        }
        let totalSeconds = currentProgressValue * durationInSeconds
        self.progressCompletionTime = totalSeconds.formatTime()
    }
    
    /// This method schedules the `Timer` after some `delay` provided by the user
    func startTimer(with delay: DispatchTimeInterval) {
        setupProgressValue()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self else {return}
            self.scheduleTimer()
        }
    }
    
    /// This method schedules the `Timer` immediately
    func startTimer() {
        setupProgressValue()
        scheduleTimer()
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func setupProgressValue() {
        if reverse {
            currentProgressValue = 1.0 - initialProgressValue
        } else {
            currentProgressValue = initialProgressValue
        }
        progressEnded = false
        progressCompletionTime = "00:00"
        showShimmer = true
    }
    
    private func incrementProgress() {
        if currentProgressValue < 1.0 {
            // Ensure the progress does not exceed 1.0
            currentProgressValue = min(currentProgressValue + updationValue, 1.0)
        } else {
            // Invalidate the timer when progress reaches 1.0
            invalidateTimer()
            progressEnded = true
        }
    }
    
    private func decrementProgess() {
        if currentProgressValue > 0.0 {
            // Ensure the progress does not subceed 0.0
            currentProgressValue = max(currentProgressValue - updationValue, 0.0)
        } else {
            // Invalidate the timer when progress reaches 0.0
            invalidateTimer()
            progressEnded = true
        }
    }
}
