//
//  PagerViewModel.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 25/05/24.
//

import Combine
import SwiftUI

class PagerViewModel: ObservableObject {
    @Published var selectedPage: Int = 0
    
    let stories: [Story] = jarStories
    let animationDuration: CGFloat = 4
    private var timer: Timer?
    private var cancellable: AnyCancellable?
    
    var totalNoofPages: Int {
        stories.count
    }
    var lastStory: Story? {
        stories.last
    }
    private var isLastPage: Bool {
        selectedPage == totalNoofPages - 1
    }
    
    init() {
        subscribeToPublisher()
    }
    
    deinit {
        // Cancel the subscription when the instance is deallocated
        cancellable?.cancel()
        cancelTimer()
    }
    
    private func subscribeToPublisher() {
        cancellable = $selectedPage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else {return}
                self.restartTimer()
            }
    }
    
    /// If pages are not more than 1 then there is no need of PageControl and no need to instantiate Timer
    func onAppear() {
        if totalNoofPages > 1 {
            startTimer()
        }
    }
    
    /// Change the page at regular intervals which are published by Timer
    func goToNextPage() {
        selectedPage = isLastPage ? selectedPage : selectedPage + 1
    }
    
    /// Initiating Timer which publishes an event approximately for every `animationDuration`.
    private func startTimer() {
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
