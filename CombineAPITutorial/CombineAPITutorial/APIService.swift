//
//  APIService.swift
//  CombineAPITutorial
//
//  Created by USER on 2023/01/04.
//

import Foundation
import Combine

enum API {
    case fetchTodos // 할 일 가져오기
    case fetchPosts // 포스트 가져오기
    case fetchUsers // 유저 가져오기
    
    var url: URL {
        switch self {
        case .fetchTodos:
            return URL(string: "https://jsonplaceholder.typicode.com/todos")!
        case .fetchPosts:
            return URL(string: "https://jsonplaceholder.typicode.com/posts")!
        case .fetchUsers:
            return URL(string: "https://jsonplaceholder.typicode.com/users")!
        }
    }
}

// struct로 할 수도 있음
enum APIService {
    // static : 객체 인스턴스를 만들지 않아도 함수를 호출할 수 있음
    static func fetchTodos() -> AnyPublisher<[Todo], Error> {
        print("APIService - fetchTodos()")
        return URLSession.shared.dataTaskPublisher(for: API.fetchTodos.url)
            .map { $0.data }
            .decode(type: [Todo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func fetchPosts(_ todosCount: Int = 0) -> AnyPublisher<[Post], Error> {
        print("APIService - fetchPosts() todosCount: \(todosCount)")
        return URLSession.shared.dataTaskPublisher(for: API.fetchPosts.url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func fetchUsers() -> AnyPublisher<[User], Error> {
        print("APIService - fetchUsers()")
        return URLSession.shared.dataTaskPublisher(for: API.fetchUsers.url)
            .map { $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    /// Todos + Posts 동시 호출
    /// - Returns:
    static func fetchTodosAndPostsAtTheSameTime() -> AnyPublisher<([Todo], [Post]), Error> {
        let fetchedTodos = fetchTodos()
        let fetchedPosts = fetchPosts()
        
        return Publishers.CombineLatest(fetchedTodos, fetchedPosts).eraseToAnyPublisher()
    }
    
    /// Todos 호출 뒤에 그 결과로 Posts 호출
    /// - Returns:
    static func fetchTodosAndThenPosts() -> AnyPublisher<[Post], Error> {
        return fetchTodos().flatMap { todos in
            return fetchPosts(todos.count).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    /// Todos 호출 뒤에 그 결과로 특정 조건이 성립되면 Posts 호출
    /// - Returns:
    static func fetchTodosAndThenPostsConditionally() -> AnyPublisher<[Post], Error> {
        return fetchTodos()
            .map { $0.count }
            .filter { $0 < 200 }
            .flatMap { _ in
                return fetchPosts().eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
