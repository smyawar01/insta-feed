//
//  FeedViewModel.swift
//  insta-feed
//
//  Created by Apple on 26/04/2025.
//
import Foundation
import Combine

public enum FeedViewState {
    
    case initial
    case loading
    case loaded([Post])
    case loadMore
    case feedError(String)
}
public protocol FeedViewModelProtocol: ObservableObject {
    
    var state: FeedViewState { get }
    func fetchPosts()
    func loadMore()
}
public class FeedViewModel: FeedViewModelProtocol {
    
    private let fetchUseCase: FetchFeedUseCase
    private let loadMoreUseCase: LoadMoreUseCase
    private var currentPage: Int = 1
    private var hasMore: Bool = true
    private var posts: [Post] = []
    
    @Published public private(set) var state: FeedViewState = .initial
    
    public init(fetchUseCase: FetchFeedUseCase, loadMoreUseCase: LoadMoreUseCase) {
        
        self.fetchUseCase = fetchUseCase
        self.loadMoreUseCase = loadMoreUseCase
    }
    public func fetchPosts() {
        Task {
            self.posts = []
            self.currentPage = 1
            await self.updateState(state: .loading)
            do {
                let (posts, hasMore) = try await self.fetchUseCase.execute()
                self.hasMore = hasMore
                self.posts.append(contentsOf: posts)
                await self.updateState(state: .loaded(self.posts))
            } catch(let error) {
                await self.updateState(state: .feedError(error.localizedDescription))
            }
        }
    }
    public func loadMore() {
        
        guard hasMore else { return }
        currentPage += 1
        Task {
            await self.updateState(state: .loadMore)
            do {
                let (posts, hasMore) = try await self.loadMoreUseCase.execute(with: currentPage)
                self.hasMore = hasMore
                self.posts.append(contentsOf: posts)
                await self.updateState(state: .loaded(self.posts))
            } catch(let error) {
                await self.updateState(state: .feedError(error.localizedDescription))
            }
        }
    }
}

private extension FeedViewModel {
    
    @MainActor
    func updateState(state: FeedViewState) {
        
        self.state = state
    }
}
