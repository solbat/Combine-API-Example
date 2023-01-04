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
    
    func fetchPosts() {
        APIService.fetchPosts()
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("ViewModel - fetchPosts: err: \(err)")
                case .finished:
                    print("ViewModel - fetchPosts: finished")
                }
            } receiveValue: { posts in
                print("ViewModel - fetchPosts: posts.count: \(posts.count)")
            }.store(in: &subscriptions)
    }
    
    func fetchTodosAndPostsAtTheSameTime() {
        APIService.fetchTodosAndPostsAtTheSameTime()
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("ViewModel - fetchTodosAndPostsAtTheSameTime: err: \(err)")
                case .finished:
                    print("ViewModel - fetchTodosAndPostsAtTheSameTime: finished")
                }
            } receiveValue: { (todos: [Todo], posts: [Post]) in
                print("ViewModel - fetchTodosAndPostsAtTheSameTime: todos.count: \(todos.count), posts.count: \(posts.count)")
            }.store(in: &subscriptions)
    }
    
    func fetchTodosAndThenPost() {
        APIService.fetchTodosAndThenPosts()
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("ViewModel - fetchTodosAndThenPosts: err: \(err)")
                case .finished:
                    print("ViewModel - fetchTodosAndThenPosts: finished")
                }
            } receiveValue: { posts in
                print("ViewModel - fetchTodosAndThenPosts: posts.count: \(posts.count)")
            }.store(in: &subscriptions)
    }
    
    func fetchTodosAndThenPostsConditionally() {
        APIService.fetchTodosAndThenPostsConditionally()
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("ViewModel - fetchTodosAndThenPostsConditionally: err: \(err)")
                case .finished:
                    print("ViewModel - fetchTodosAndThenPostsConditionally: finished")
                }
            } receiveValue: { posts in
                print("ViewModel - fetchTodosAndThenPostsConditionally: posts.count: \(posts.count)")
            }.store(in: &subscriptions)
    }
}
