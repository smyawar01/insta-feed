//
//  LoadMoreUseCase.swift
//  insta-feed
//
//  Created by Apple on 28/04/2025.
//

import Foundation

public protocol LoadMoreUseCase {
    
    func execute(with page: Int) async throws -> ([Post], Bool)
}
public struct LoadMoreUseCaseImpl: LoadMoreUseCase {
    
    private let repo: FeedRespository
    
    public init(repo: FeedRespository) {
        
        self.repo = repo
    }
    public func execute(with page: Int) async throws -> ([Post], Bool) {
        
        do {
            return try await self.repo.fetchPosts(page: page, pageSize: 5)
        } catch(let error) {
            
            throw error
        }
    }
}
