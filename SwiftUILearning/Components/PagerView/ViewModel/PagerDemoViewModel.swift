//
//  PagerDemoViewModel.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 02/06/24.
//

import Combine
import SwiftUI

class PagerDemoViewModel: ObservableObject {
    @Published var pagerViewModel: PagerViewModel = PagerViewModel(animationDuration: 4)
    @Published var stories: [Story] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
        $stories.sink { [weak self] stories in
            guard let self else { return }
            self.pagerViewModel.update(totalNoofPages: stories.count)
        }.store(in: &cancellables)
        
        var jarStories = jarStories
        let timer = Timer.scheduledTimer(withTimeInterval: 25, repeats: true) { [weak self] _ in
            guard let self else {return}
            jarStories = jarStories.shuffled()
            self.updateStories(stories: jarStories)
        }
        RunLoop.main.add(timer, forMode: .common)
    }
    
    deinit {
        print("\(Self.self) is de-initialised")
        cancellables.forEach { $0.cancel() }
    }
    
    var lastStory: Story? {
        stories.last
    }
    
    var showShimmerAnimation: Bool {
        stories.count == 0
    }
    /// We are subscribing to the changes from child viewmodel
    /// - Note: Call to this method is necessary to observe the changes from child viewmodel
    func setupBindings() {
        pagerViewModel.objectWillChange.sink { [weak self] in
            guard let self else {return}
            self.objectWillChange.send()
        }.store(in: &cancellables)
    }
    
    func fetchStories() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            guard let self else { return }
            self.stories  = jarStories
        }
    }
    
    func updateStories(stories: [Story]) {
        self.stories.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            self.stories  = stories
        }
    }
}
