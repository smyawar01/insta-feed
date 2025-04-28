//
//  PostHeaderView.swift
//  insta-feed
//
//  Created by Apple on 27/04/2025.
//

import SwiftUI
struct PostHeaderView: View {
    
    let avatarLink: String?
    let userName: String
    
    var body: some View {
        HStack {
            Avatar(url: avatarLink)
            Text(userName)
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
        }
    }
}
#Preview{
    PostHeaderView(avatarLink: nil,
                   userName: "Yawar")
}
