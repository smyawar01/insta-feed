//
//  Avatar.swift
//  insta-feed
//
//  Created by Apple on 27/04/2025.
//

import SwiftUI

struct Avatar: View {
    
    let url: String?
    
    var body: some View {
        
        CachedImage(imageName: "NoAvatar")
            .scaledToFill()
            .frame(width: 32, height: 32)
            .clipShape(Circle())
    }
}

#Preview {
    Avatar(url: "NoAvatar")
}
