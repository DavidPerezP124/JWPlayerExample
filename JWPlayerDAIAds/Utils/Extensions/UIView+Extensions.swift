//
//  UIView+Extensions.swift
//  JWPlayerDAIAds
//
//  Created by David Perez on 10/22/20.
//

import Foundation

extension UIView{
    func fitToSuperview(){
        translatesAutoresizingMaskIntoConstraints = false
        func makeContraints(dimension str:String) -> [NSLayoutConstraint] {
            return NSLayoutConstraint.constraints(withVisualFormat: "\(str):|[view]|", options:[], metrics: nil, views: ["view":self])
        }
        NSLayoutConstraint.activate(makeContraints(dimension: "H") + makeContraints(dimension: "V"))
    }
    
}
