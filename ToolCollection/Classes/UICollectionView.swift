//
//  UICollectionView.swift
//  Template
//
//  Created by Endless Summer on 2019/8/26.
//  Copyright © 2019 flow. All rights reserved.
//

import Foundation
import DifferenceKit

public extension UICollectionView {
    func reload(oldIDs: [String], newIDs: [String]) {
        let change = StagedChangeset(source: oldIDs, target: newIDs)
        
        self.reload(using: change, setData: { (_) in
            
        })
    }
}

extension String: Differentiable {}
