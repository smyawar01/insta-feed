//
//  Post.swift
//  insta-feed
//
//  Created by Apple on 26/04/2025.
//

import Foundation

public struct Post: Identifiable, Equatable {
    
    public let id = UUID()
    let username: String
    let avatarLink: String?
    let imageLink: String?
    let videoLink: String?
    let caption: String
    let likes: Int
    let comments: [Comment]
    let timestamp: String
}

struct Comment: Equatable {
    let username: String
    let text: String
}
