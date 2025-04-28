//
//  MediaContentView.swift
//  insta-feed
//
//  Created by Apple on 27/04/2025.
//

import SwiftUI
import AVKit

import SwiftUI
import AVKit
import AVFoundation

enum MediaSource {
    case remote(url: String)
    case localImage(name: String)
    case localVideo(name: String, extension: String)
}

struct MediaContentView: View {
    let imageSource: String?
    let videoSource: String?
    @State private var player: AVPlayer?
    @State private var currentPage = 0
    
    var body: some View {
        Group {
            if let imageSource = imageSource,
               let videoSource = videoSource,
               let (name, ext) = fileNameAndExt(videoSource: videoSource) {
                
                paginatedMediaView(imageSource: .localImage(name: imageSource),
                                   videoSource: .localVideo(name: name,
                                                            extension: ext)
                )
                
            } else if let imageSource = imageSource {
                mediaImage(source: .localImage(name: imageSource))
            } else if let videoSource = videoSource,
                      let (name, ext) = fileNameAndExt(videoSource: videoSource) {
                mediaVideo(source: .localVideo(name: name, extension: ext))
            } else {
                
                EmptyView()
            }
        }
        .background(Color.black)
        .onDisappear {
            player?.pause()
            player = nil
        }
    }
    //MARK: Paginated View with Image & Video
    @ViewBuilder
    private func paginatedMediaView(imageSource: MediaSource, videoSource: MediaSource) -> some View {
        GeometryReader { geometry in
            TabView(selection: $currentPage) {
                mediaImage(source: imageSource)
                    .tag(0)
                
                mediaVideo(source: videoSource)
                    .tag(1)
                    .onAppear {
                        player?.play()
                    }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .frame(width: geometry.size.width)
            .onChange(of: currentPage, { old, new in
                if new != 1 { // If not on video page
                    player?.pause()
                } else {
                    player?.play()
                }
            })
        }
    }
    //MARK: Paginated View with Only Image
    @ViewBuilder
    private func mediaImage(source: MediaSource) -> some View {
        switch source {
        case .remote(let url):
            AsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            
        case .localImage(let name):
            CachedImage(imageName: name)
                .aspectRatio(contentMode: .fit)
         default:
            EmptyView()
        }
    }
    //MARK: Paginated View with only Video
    @ViewBuilder
    private func mediaVideo(source: MediaSource) -> some View {
        switch source {
        case .remote(let url):
            VideoPlayer(player: player)
                .aspectRatio(16/9, contentMode: .fit)
                .onAppear {
                    setupPlayer(with: URL(string: url))
                    player?.play()
                }
            
        case .localVideo(let name, let ext):
            VideoPlayer(player: player)
                .aspectRatio(16/9, contentMode: .fit)
                .onAppear {
                    if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                        setupPlayer(with: url)
                        player?.play()
                    }
                }
        default:
            EmptyView()
        }
    }
    
    private func setupPlayer(with url: URL?) {
        guard let url = url else { return }
        player = AVPlayer(url: url)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                              object: player?.currentItem,
                                              queue: .main) { _ in
            player?.seek(to: .zero)
            player?.play()
        }
    }
    private func fileNameAndExt(videoSource: String) -> (String, String)? {
        let videoComponents = videoSource.components(separatedBy: ".")
        if videoComponents.count > 1,
           let first = videoComponents.first,
           let last = videoComponents.last {
            return (first, last)
        }
        return nil
    }
}
#Preview {
    
    MediaContentView(imageSource: "ghibli",
                     videoSource: "clouds.mp4")
}
