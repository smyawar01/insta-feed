//
//  CachedImageView.swift
//  insta-feed
//
//  Created by Apple on 28/04/2025.
//

import SwiftUI

struct CachedImage: View {
    
    let imageName: String
    @State private var image: Image?
    
    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
            } else {
                ProgressView()
                    .onAppear(perform: loadImage)
            }
        }
    }
    private func loadImage() {
            // Check cache first
            if let cachedImage = ImageCache.shared.get(imageName) {
                self.image = Image(uiImage: cachedImage)
                return
            }
            
            // Load from assets if not in cache
            DispatchQueue.global(qos: .userInitiated).async {
                if let uiImage = UIImage(named: imageName) {
                    // Store in cache
                    ImageCache.shared.set(uiImage, forKey: imageName)
                    
                    DispatchQueue.main.async {
                        self.image = Image(uiImage: uiImage)
                    }
                }
            }
        }
}

#Preview {
    CachedImage(imageName: "dskljf")
}
