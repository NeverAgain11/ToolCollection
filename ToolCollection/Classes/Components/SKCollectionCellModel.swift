//
//  JKCollectionCellModel.swift
//  IconChanger
//
//  Created by Endless Summer on 2019/8/23.
//  Copyright © 2019 flow. All rights reserved.
//

import Foundation
import YHListKit

open class SKCollectionCellModel<T>: YHCollectionViewCellModel where T: UICollectionViewCell {
    
    override public init() {
        super.init()
        
        cellClass = T.self
    }
    
    open func didDequeueCell(_ closure: @escaping ((T, IndexPath) -> Void)) {
        didDequeueCell = { cell, indexPath in
            guard let cell = cell as? T else { return }
            closure(cell, indexPath)
        }
    }
    
    open func willDisplayCell(_ closure: @escaping ((T, IndexPath) -> Void)) {
        willDisplayCell = { cell, indexPath in
            guard let cell = cell as? T else { return }
            closure(cell, indexPath)
        }
    }
    
    open func didSelect(_ closure: @escaping ((UICollectionView, IndexPath) -> Void)) {
        didSelectItem = closure
    }
    
}

public extension YHCollectionViewCellModel {
    @discardableResult
    open func cellWidth(_ width: CGFloat) -> YHCollectionViewCellModel {
        self.cellWidth = width
        return self
    }
    
    @discardableResult
    open func cellHeight(_ height: CGFloat) -> YHCollectionViewCellModel {
        self.cellHeight = height
        return self
    }
    
    @discardableResult
    open func dataModel(_ model: Any) -> YHCollectionViewCellModel {
        self.dataModel = model
        return self
    }
    
}
