//
//  VideoCollectionViewController.swift
//  JWPlayerDAIAds
//
//  Created by David Perez on 10/22/20.
//

import UIKit

let videoUrl = "http://playertest.longtailvideo.com/adaptive/oceans/oceans.m3u8"
class VideoCollectionViewController: UICollectionViewController {
    
    
    var feed = [JWPlayerController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.identifier)
        collectionView.collectionViewLayout = generateLayout()
        populateFeed()
        setupCollectionView()
    }
    
    func setupCollectionView(){
        self.collectionView.fitToSuperview()
    }
    
    
    func populateFeed(){
        guard let feedFilePath = Bundle.main.path(forResource: "Items", ofType: "plist"),
              let feedInfo = NSArray(contentsOfFile: feedFilePath) as? [Dictionary<String, String>] else {
            return
        }

        // Populate the feed array with video players
        
        
        for itemInfo in feedInfo {
           
            
            guard let config = createConfig(info:itemInfo) else {
                continue
            }
            // Create the DAI Config
            
            if let player = JWPlayerController(config: config) {
                feed.append(player)
            }
        }
    }

    func createConfig(info: Dictionary<String,String>) -> JWConfig? {
        guard let url = info["url"] else {return nil}
        let config = JWConfig.init(contentUrl:url)
        config.title = info["title"] ?? "No Title"
        config.autostart = false
        config.repeat = false
        return config;
    }
    
   
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return feed.isEmpty ? 0 : 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return feed.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier, for: indexPath) as? VideoCell else {
            fatalError()
        }
    
        // Configure the cell
        let cellPlayer = feed[indexPath.row]
        cell.player = cellPlayer
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height)
    }

    
    func generateLayout() -> UICollectionViewLayout {
      //1
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0))
      let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
      //2
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalWidth(2/3))
      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: groupSize,
        subitem: fullPhotoItem,
        count: 1)
      //3
      let section = NSCollectionLayoutSection(group: group)
      let layout = UICollectionViewCompositionalLayout(section: section)
      return layout
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
}
