//
//  LinearProgressViewDemoViewModel.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 01/06/24.
//

import Combine
import Foundation
import SwiftUI

class LinearProgressDemoViewModel: ObservableObject {
    @Published var linearProgressViewModel: LinearProgressViewModel
    var cancellable: AnyCancellable?
    
    init(linearProgressViewModel: LinearProgressViewModel) {
        self.linearProgressViewModel = linearProgressViewModel
        setupBindings()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    /// We are subscribing to the changes from child viewmodel
    /// - Note: Call to this method is necessary to observe the changes from child viewmodel
    func setupBindings() {
        self.cancellable = linearProgressViewModel.objectWillChange.sink { [weak self] in
            guard let self else {return}
            self.objectWillChange.send()
        }
    }
    
    func requestGoldPriceValidity() {
        let validity = Double.random(in: 10.0 ... 30.0)
        Task {
            await linearProgressViewModel.updateDuration(validity)
        }
    }
    
    func startTimer() {
        Task {
            await linearProgressViewModel.startTimer()
        }
    }
    
    func stopTimer() {
        Task {
           await linearProgressViewModel.invalidateTimer()
        }
    }
    
}
