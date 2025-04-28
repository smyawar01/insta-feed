//
//  FeedPostActionButtons.swift
//  insta-feed
//
//  Created by Apple on 27/04/2025.
//

import SwiftUI
struct FeedPostActionButtons: View {
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Button(action: {}) {
                Image(systemName: "heart")
            }
            Button(action: {}) {
                Image(systemName: "message")
            }
            Button(action: {}) {
                Image(systemName: "paperplane")
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "bookmark")
            }
        }
        .padding(.vertical, 6)
        .font(.system(size: 24))
    }
}
