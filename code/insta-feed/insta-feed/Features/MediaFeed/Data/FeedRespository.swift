//
//  FeedRespository.swift
//  insta-feed
//
//  Created by Apple on 26/04/2025.
//

import Foundation

public protocol FeedRespository {
    
    func fetchPosts(page: Int, pageSize: Int) async throws -> ([Post], Bool)
}

public struct LocalFeedRepository: FeedRespository {
    
    public func fetchPosts(page: Int, pageSize: Int) async throws -> ([Post], Bool) {
        
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        let allPosts = MediaFixtures.posts
        let startIndex = (page - 1) * pageSize
        guard startIndex < allPosts.count else {
            return ([], false)
        }
        let endIndex = min(startIndex + pageSize, allPosts.count)
        let newPosts = Array(allPosts[startIndex..<endIndex])
        
        let hasMore = newPosts.count == page * pageSize
        return (newPosts, hasMore)
    }
}
