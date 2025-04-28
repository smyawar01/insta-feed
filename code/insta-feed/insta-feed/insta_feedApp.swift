//
//  insta_feedApp.swift
//  insta-feed
//
//  Created by Apple on 26/04/2025.
//

import SwiftUI

@main
struct insta_feedApp: App {
    
    let mediaComponent = MediaFeedComponent()
    
    var body: some Scene {
        WindowGroup {
            mediaComponent.mediaFeedView
        }
    }
}
