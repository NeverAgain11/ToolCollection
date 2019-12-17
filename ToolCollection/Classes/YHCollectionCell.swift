//
//  YHCollectionCell.swift
//  AowzWallpaper
//
//  Created by ljk on 2019/3/18.
//  Copyright © 2019 flow. All rights reserved.
//

import Foundation
import YHListKit

public class YHCollectionCell: UICollectionViewCell, YHCollectionViewCell, YHCollectionViewSectionHeaderFooter {
    
    public var cellModel: YHCollectionViewCellModel?
    
    public var sectionModel: YHCollectionViewSectionModel? {
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
    
    public func willDisplay() {
        if let model = cellModel {
            updateUI(model.dataModel)
        }
    }
    
    public func updateUI(_ data: Any) {
        
    }
    
    public func setupUI() {
        
    }
    
}