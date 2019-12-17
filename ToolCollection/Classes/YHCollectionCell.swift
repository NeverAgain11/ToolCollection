//
//  YHCollectionCell.swift
//  AowzWallpaper
//
//  Created by ljk on 2019/3/18.
//  Copyright © 2019 flow. All rights reserved.
//

import Foundation
import YHListKit

class YHCollectionCell: UICollectionViewCell, YHCollectionViewCell, YHCollectionViewSectionHeaderFooter {
    
    var cellModel: YHCollectionViewCellModel?
    
    var sectionModel: YHCollectionViewSectionModel? {
        didSet {
            guard let model = sectionModel?.headerModel else { return }
            updateUI(model)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func willDisplay() {
        if let model = cellModel {
            updateUI(model.dataModel)
        }
    }
    
    func updateUI(_ data: Any) {
        
    }
    
    func setupUI() {
        
    }
    
}
