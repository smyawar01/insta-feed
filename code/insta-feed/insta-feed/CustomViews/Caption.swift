//
//  Caption.swift
//  insta-feed
//
//  Created by Apple on 27/04/2025.
//

import SwiftUI

struct Caption: View {
    
    let name: String
    let caption: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 4) {
            Text(name)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(caption)
                .font(.subheadline)
            Spacer()
        }
        .foregroundStyle(Color.textPrimary)
    }
}
