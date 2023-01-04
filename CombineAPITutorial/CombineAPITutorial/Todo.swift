//
//  Todo.swift
//  CombineAPITutorial
//
//  Created by USER on 2023/01/04.
//

import Foundation

// MARK: - Todo
struct Todo: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}
