//
//  ActorsBootcampManager.swift
//  SwiftConcurrency
//
//  Created by Venkata Ajay Sai Nellori on 11/03/24.
//

import Foundation
class MyDataManager {
    static let instance = MyDataManager()
    private init() {}
    /// Shared data
    var data: [String] = []
    let lock = DispatchQueue(label: "com.MyApp.MyDataManager") // The reason for adding label here is it will come up in the debug logs
    /// Data race occurs at line no 16
    func getRandomData() -> String? {
        data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }

    /// DispatchQueue solved data race because we are asynchronously waiting for one thread to complete the task before another thread proceeds
    func getRandomData1(completionHandler: @escaping (_ title: String?) -> Void) {
        // Since we are using async block and we can't return out of async environment we are using completion handlers to pass the output randomElement
        
        
        // When two different threads are trying to call this getRandomData1 function it need to asynchronously wait for the other thread to complete the task because those threads are lining up in the queue
        lock.async { [weak self] in
            guard let self else {return}
            self.data.append(UUID().uuidString)
            print(Thread.current)
            completionHandler(self.data.randomElement())
        }
    }
}

actor MyActorDataManager {
    static let instance = MyActorDataManager()
    private init() {}
    /// Shared data
    /// The data is isolated with actor
    var data: [String] = []
    /// There is no data race because we are awaiting the result of getRandomData(). There is a suspention point at every function call and it only resumes once the task is completed inside this function.
    func getRandomData() -> String? {
        data.append(UUID().uuidString)
        print(Thread.current)
        return data.randomElement()
    }
    
    /// By default all the properties and methods are isolated to the actor that they are in.
    /// getNewData method is not accessing shared data so there is no need for the function to be isolated to the actor. Hence we are declaring it as nonisolated.
    /// Nonisolated methods or properties are non asynchronous
    nonisolated func getNewData() -> String {
        "New String"
    }
}
