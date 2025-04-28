//
//  File.swift
//  insta-feed
//
//  Created by Apple on 28/04/2025.
//

import SwiftUI

struct TimeStamp: View {
    let timeStamp: String
    var body: some View {
        Text(timeStamp)
            .font(.caption)
            .foregroundColor(.gray)
    }
}
