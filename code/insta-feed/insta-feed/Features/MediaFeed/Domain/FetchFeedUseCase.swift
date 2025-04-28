//
//  FetchFeedUseCase.swift
//  insta-feed
//
//  Created by Apple on 26/04/2025.
//
import Foundation

public protocol FetchFeedUseCase {
    
    func execute() async throws -> ([Post], Bool)
}
public struct FetchFeedUseCaseImpl: FetchFeedUseCase {
    
    private let repo: FeedRespository
    
    public init(repo: FeedRespository) {
        
        self.repo = repo
    }
    public func execute() async throws -> ([Post], Bool) {
        
        do {
            return try await self.repo.fetchPosts(page: 1, pageSize: 5)
        } catch(let error) {
            
            throw error
        }
    }
}
