//
//  VideoCollectionViewController.swift
//  JWPlayerDAIAds
//
//  Created by David Perez on 10/22/20.
//

import UIKit

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
        
        //VOD test tag
        let adBreak = JWAdBreak(tag: "https://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/124319096/external/ad_rule_samples&ciu_szs=300x250&ad_rule=1&impl=s&gdfp_req=1&env=vp&output=vmap&unviewed_position_start=1&cust_params=deployment%3Ddevsite%26sample_ar%3Dpreonly&cmsid=496&vid=short_onecue&correlator=", offset: "pre")
        
        let adConfig = JWAdConfig()
        adConfig.client = .googima
        adConfig.schedule = [adBreak]
        config.advertising = adConfig
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
        section.orthogonalScrollingBehavior = .groupPagingCentered
      let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration.scrollDirection = .horizontal
      return layout
    }
}
