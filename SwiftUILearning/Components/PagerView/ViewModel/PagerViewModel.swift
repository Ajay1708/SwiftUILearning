//
//  PagerViewModel.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 25/05/24.
//

import Combine
import SwiftUI

class PagerViewModel: ObservableObject {
    @Published var selectedPage: Int
    
    var totalNoofPages: Int
    let animationDuration: CGFloat
    private var timer: Timer?
    private var cancellable: AnyCancellable?
    
    init(totalNoofPages: Int = 0, selectedPage: Int = 0, animationDuration: CGFloat) {
        self.totalNoofPages = totalNoofPages
        self.selectedPage = selectedPage
        self.animationDuration = animationDuration
        subscribeToPublisher()
    }
    
    deinit {
        // Cancel the subscription when the instance is deallocated
        cancellable?.cancel()
        cancelTimer()
    }
    
    func update(totalNoofPages: Int) {
        self.totalNoofPages = totalNoofPages
        self.selectedPage = 0
        startTimer()
    }
    
    private var isLastPage: Bool {
        selectedPage == totalNoofPages - 1
    }
    
    private func subscribeToPublisher() {
        cancellable = $selectedPage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else {return}
                self.restartTimer()
            }
    }
    
    /// Change the page at regular intervals which are published by Timer
    func goToNextPage() {
        selectedPage = isLastPage ? selectedPage : selectedPage + 1
    }
    
    /// Initiating Timer which publishes an event approximately for every `animationDuration`.
    ///  - Note: Timer won't be initialised `if totalNoofPages <= 1`
    func startTimer() {
        guard totalNoofPages > 1 else { return }
        timer = Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false, block: { [weak self] timer in
            guard let self else {return}
            DispatchQueue.main.async {
                self.goToNextPage()
            }
        })
    }
    
    private func cancelTimer() {
        timer?.invalidate()
    }
    
    /// - Restart the Timer when the selectedPage changes Due to any of the following reasons
    ///   - When The User slides forward to the new page or slides backword to the previous page
    ///   - When User Clicks on the right arrow button to proceed to the new page
    ///   - When Timer publishes a value
    private func restartTimer() {
        cancelTimer()
        /// Cancel the ongoing timer before starting it again on the basis of LastPage check
        if !isLastPage {
            startTimer()
        }
    }
}
