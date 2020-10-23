//
//  AdDelegate.swift
//  JWPlayerDAIAds
//
//  Created by David Perez on 10/22/20.
//

import Foundation

protocol AdDelegate {
    func setupAds(config: JWConfig)
    func requestAds()
}
