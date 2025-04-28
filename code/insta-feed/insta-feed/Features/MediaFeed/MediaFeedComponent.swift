//
//  MediaComponent.swift
//  insta-feed
//
//  Created by Apple on 26/04/2025.
//

import Foundation
import SwiftUI

struct MediaFeedComponent: MediaFeedViewBuilder {

    var feedViewModel: FeedViewModel {
        
        FeedViewModel(
            fetchUseCase: fetchUseCase,
            loadMoreUseCase: loadMoreUseCase
        )
    }
    var fetchUseCase: FetchFeedUseCase {
        
        FetchFeedUseCaseImpl(repo: feedRepository)
    }
    var loadMoreUseCase: LoadMoreUseCase {
        
        LoadMoreUseCaseImpl(repo: feedRepository)
    }
    var feedRepository: FeedRespository {
        LocalFeedRepository()
    }
    var mediaFeedView: AnyView {
        
        AnyView(
            MainFeedView(viewModel: feedViewModel)
        )
    }
}
protocol MediaFeedViewBuilder {
    
    var mediaFeedView: AnyView { get }
}

