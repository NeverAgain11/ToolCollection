//
//  YHCollectionCell.swift
//  AowzWallpaper
//
//  Created by ljk on 2019/3/18.
//  Copyright © 2019 flow. All rights reserved.
//

import Foundation
import YHListKit
import AsyncDisplayKit

open class SKCollectionCell: UICollectionViewCell, YHCollectionViewCell, YHCollectionViewSectionHeaderFooter {
    
    public var cellModel: YHCollectionViewCellModel? {
        didSet {
            if let model = cellModel {
                updateUI(model.dataModel)
            }
        }
    }
    
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
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func updateUI(_ data: Any) {
        
    }
    
    open func setupUI() {
        
    }
    
    public func willDisplay() {
        
    }
}

open class SKCollectionNodeCell<Node>: SKCollectionCell where Node: ASDisplayNode {
    
    public let node = Node()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubnode(node)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        node.frame = bounds
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    open func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//      return ASWrapperLayoutSpec(layoutElements: [])
//    }
}

open class SKBaseView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupData()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configure() {
        
    }
    
    open func setupData() {
        
    }
    
}

open class SKControl: UIControl {
    
    public typealias SKControlAction = (_ sender: SKControl) -> Void
    
    open var action: SKControlAction?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupData()
        
        addTarget(self, action: #selector(SKControl.didPressed(_:)), for: .touchUpInside)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func addAction(_ action: @escaping SKControlAction) {
        self.action = action
    }
    
    @objc open func didPressed(_ sender: SKControl) {
        action?(sender)
    }
    
    open func configure() {
        
    }
    
    open func setupData() {
        
    }
    
}
