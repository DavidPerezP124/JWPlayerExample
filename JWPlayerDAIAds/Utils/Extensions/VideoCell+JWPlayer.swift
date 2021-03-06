//
//  VideoCell+JWPlayer.swift
//  JWPlayerDAIAds
//
//  Created by David Perez on 10/22/20.
//

import Foundation

extension VideoCell: JWPlayerDelegate {
    
    
    
    func onReady(_ event: JWEvent & JWReadyEvent) {
        print("On ready")
        print("Setup time: \(event.setupTime)")
       
        if let videoTitle = player?.config.title {
            print("Video title: \(videoTitle)")
        }
    }

    func onPlay(_ event: JWEvent & JWStateChangeEvent) {
        print("On play")
        if let videoTitle = player?.config.title {
            print("Video title: \(videoTitle)")
        }
    }

    func onPause(_ event: JWEvent & JWStateChangeEvent) {
        print("On pause")
        
        if let videoTitle = player?.config.title {
            print("Video title: \(videoTitle)")
        }
    }

    func onFirstFrame(_ event: JWEvent & JWFirstFrameEvent) {
        print("On first frame")
        print("Load time: \(event.loadTime)")
        if let videoTitle = player?.config.title {
            print("Video title: \(videoTitle)")
        }
    }

    func onIdle(_ event: JWEvent & JWStateChangeEvent) {
        print("On idle")
        if let videoTitle = player?.config.title {
            print("Video title: \(videoTitle)")
        }
    }
    
    func onError(_ event: JWEvent & JWErrorEvent) {
        print("On error")
        if let videoTitle = player?.config.title {
            print("Video title: \(videoTitle)")
        }
    }
    
    func onAdError(_ event: JWAdEvent & JWErrorEvent) {
        print("On ad error")
        if let videoTitle = player?.config.title {
            print("Video title: \(videoTitle)")
        }
    }
    func onAdRequest(_ event: JWAdEvent & JWAdRequestEvent) {
        if let ad = player?.config.advertising?.adMessage {
            print("ad message: \(ad)")
        }
    }

}
