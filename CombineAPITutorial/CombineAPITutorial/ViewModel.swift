//
//  ViewModel.swift
//  CombineAPITutorial
//
//  Created by USER on 2023/01/04.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    func fetchTodos() {
        APIService.fetchTodos()
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("ViewModel - fetchTodos: err: \(err)")
                case .finished:
                    print("ViewModel - fetchTodos: finished")
                }
            } receiveValue: { todos in
                print("ViewModel - fetchTodos: todos.count: \(todos.count)")
            }.store(in: &subscriptions)
    }
}
