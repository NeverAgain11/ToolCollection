//
//  JKCollectionCellModel.swift
//  IconChanger
//
//  Created by Endless Summer on 2019/8/23.
//  Copyright © 2019 flow. All rights reserved.
//

import Foundation
import YHListKit

open class JKCollectionCellModel<T>: YHCollectionViewCellModel where T: UICollectionViewCell {
    
    override public init() {
        super.init()
        
        cellClass = T.self
    }
    
    open func willDisplayCell(_ closure: @escaping ((T, IndexPath) -> Void)) {
        didDequeueCell = { cell, indexPath in
            guard let cell = cell as? T else { return }
            closure(cell, indexPath)
        }
    }
    
    open func didSelect(_ closure: @escaping ((UICollectionView, IndexPath) -> Void)) {
        didSelectItem = closure
    }
}
