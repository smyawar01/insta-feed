//
//  LikesView.swift
//  insta-feed
//
//  Created by Apple on 27/04/2025.
//

import SwiftUI

struct Likes: View {
    let likes: Int
    var body: some View {
        Text("\(likes) likes")
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.bottom, 2)
    }
}
