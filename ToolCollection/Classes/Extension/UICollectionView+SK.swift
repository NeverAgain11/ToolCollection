//
//  UICollectionView.swift
//  Template
//
//  Created by Endless Summer on 2019/8/26.
//  Copyright © 2019 flow. All rights reserved.
//

import Foundation
import DifferenceKit

extension String: Differentiable {}

public extension UICollectionView {
    func reload(oldIDs: [String], newIDs: [String]) {
        let change = StagedChangeset(source: oldIDs, target: newIDs)
        
        self.reload(using: change, setData: { (_) in
            
        })
    }
}

public extension SKKit where Base == UICollectionView {
    func indexPathForItem(at view: UIView?) -> IndexPath? {
        if let cell = self.base.parentCell(for: view) {
            return self.base.indexPath(for: cell)
        }
        return nil
    }
    
}

fileprivate extension UICollectionView {
    func parentCell(for view: UIView?) -> UICollectionViewCell? {
        if view?.superview == nil {
            return nil
        }
        if let cell = view?.superview as? UICollectionViewCell {
            return cell
        }
        return self.parentCell(for: view?.superview)
    }
}
