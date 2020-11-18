//
//  SKView.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/11/18.
//

import Foundation

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
