//
//  MainFeedView.swift
//  insta-feed
//
//  Created by Apple on 26/04/2025.
//

import SwiftUI

struct MainFeedView<ViewModel: FeedViewModel>: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        
        switch viewModel.state {
        case .initial:
            Color.clear
                .onAppear() {
                    viewModel.fetchPosts()
                }
        case .loading:
            ProgressView()
        case .loaded(let posts):
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(posts) { post in
                        FeedPostView(post: post)
                            .onAppear {
                                if post == posts.last {
                                    viewModel.loadMore()
                                }
                            }
                    }
                }
            }
        default:
            EmptyView()
        }
    }
}

#Preview {
    
    MediaFeedComponent().mediaFeedView
}
