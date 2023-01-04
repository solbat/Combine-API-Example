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
    
    var url: URL {
        switch self {
        case .fetchTodos:
            return URL(string: "https://jsonplaceholder.typicode.com/todos")!
        case .fetchPosts:
            return URL(string: "https://jsonplaceholder.typicode.com/posts")!
        }
    }
}

// struct로 할 수도 있음
enum APIService {
    // static : 객체 인스턴스를 만들지 않아도 함수를 호출할 수 있음
    static func fetchTodos() -> AnyPublisher<[Todo], Error> {
        return URLSession.shared.dataTaskPublisher(for: API.fetchTodos.url)
            .map { $0.data }
            .decode(type: [Todo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func fetchPosts() -> AnyPublisher<[Post], Error> {
        return URLSession.shared.dataTaskPublisher(for: API.fetchPosts.url)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
