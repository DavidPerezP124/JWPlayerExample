//
//  VideoCell.swift
//  JWPlayerDAIAds
//
//  Created by David Perez on 10/22/20.
//

import UIKit

class VideoCell: UICollectionViewCell {

    static let identifier = "com.VideoCell"
    
    var player: JWPlayerController? {
        
        didSet {
            player?.delegate = self
            if let playerView = player?.view {
                self.contentView.addSubview(playerView)
                playerView.fitToSuperview()
            }
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

