//
//  FeedPostView.swift
//  insta-feed
//
//  Created by Apple on 26/04/2025.
//
import SwiftUI

struct FeedPostView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header
            PostHeaderView(avatarLink: post.avatarLink,
                           userName: post.username)
            //media
            MediaContentView(imageSource: post.imageLink,
                             videoSource: post.videoLink)
            .frame(height: 260)
            //action button
            FeedPostActionButtons()
            
            // Likes
            Likes(likes: post.likes)
            
            // Caption
            Caption(name: post.username, caption: post.caption)

            // Timestamp
            TimeStamp(timeStamp: post.timestamp)
        }
        .padding(.horizontal, 8)
    }
}
#Preview {
    FeedPostView(post: MediaFixtures.posts[1])
}
