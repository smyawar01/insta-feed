//
//  ImageCache.swift
//  insta-feed
//
//  Created by Apple on 28/04/2025.
//
import Foundation
import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.totalCostLimit = 100 * 1024 * 1024 // 100MB memory limit
        NotificationCenter.default.addObserver(self, selector: #selector(clear), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    func get(_ key: String) -> UIImage? {
        
        return cache.object(forKey: key as NSString)
    }
    
    func set(_ image: UIImage, forKey key: String) {
        let cost = image.jpegData(compressionQuality: 1)?.count ?? 0
        cache.setObject(image, forKey: key as NSString, cost: cost)
    }
    
    @objc
    private func clear() {
        cache.removeAllObjects()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
