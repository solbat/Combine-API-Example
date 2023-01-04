//
//  Post.swift
//  CombineAPITutorial
//
//  Created by USER on 2023/01/04.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
