//
//  SettingSwitch.swift
//  ToolCollection_Example
//
//  Created by Endless Summer on 2020/4/27.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import AsyncDisplayKit

class SettingSwitchNode: UIControl {
    
    var valueChanged: ((_ isOn: Bool) -> Void)?
    
    var thumbEdge: CGFloat = 7 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var isOn: Bool = false {
        didSet {
            if !blockAction {
                setupLayout(animated: false)
            }
        }
    }
    
    lazy var onImageView: ASImageNode = {
        let imageView = ASImageNode()
        return imageView
    }()
    
    lazy var offImageView: ASImageNode = {
        let imageView = ASImageNode()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    lazy var thumbView: ASDisplayNode = {
        let view = ASDisplayNode()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .white
        return view
    }()
    
    var onThumbColor = UIColor.white
    var offThumbColor = UIColor.white
    
    private var blockAction: Bool = false
//
//    var levelObserver: Observable<UserLevel> {
//        return  UserModel.userlevelRelay.map { (level) in
//            if !UserModel.shared.isAdvanced {
//                return .normal
//            }
//            return level
//        }
//    }
//
    private var bag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 46, height: 26)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height/2
        
        onImageView.frame = self.bounds
        offImageView.frame = self.bounds
        
        thumbView.frame = thumbFrame()
        
        thumbView.layer.cornerRadius = thumbView.bounds.height/2
        thumbView.layer.masksToBounds = true
    }
    
    @objc private func buttonAction() {
        blockAction = true
        isOn.toggle()
        blockAction = false
        valueChanged?(isOn)
        
        sendActions(for: .valueChanged)
        
        setupLayout()
    }
    
    private func thumbFrame() -> CGRect {
        let height = self.frame.height - thumbEdge*2
        let top = thumbEdge
        if isOn {
            return .init(x: self.frame.width - thumbEdge - height, y: top, width: height, height: height)
        } else {
            return .init(x: thumbEdge, y: top, width: height, height: height)
        }
    }
    
    private func setupLayout(animated: Bool = true) {
        let transition: ContainedViewLayoutTransition
        if animated {
            transition = ContainedViewLayoutTransition.animated(duration: 0.2, curve: .spring)
        } else {
            transition = ContainedViewLayoutTransition.immediate
        }
        let alpha: CGFloat = isOn ? 1 : 0
        transition.updateAlpha(node: onImageView, alpha: alpha)
        
        if self.frame.size.isEmpty {
            return
        }
        transition.updateFrame(node: thumbView, frame: thumbFrame())
    }
}

// MARK: - UI
extension SettingSwitchNode {
    /// 设置页面专用 UI
    func setupSettingSwitchType() {
        bag = DisposeBag()
        
        self.onImageView.backgroundColor = .black
        self.onThumbColor = UIColor.white
    }
    
    func setupUI() {
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.layer.masksToBounds = true
        
        addSubnode(offImageView)
        addSubnode(offImageView)
        addSubnode(onImageView)
        addSubnode(thumbView)
        
        self.onImageView.backgroundColor = .black
        
        setupLayout(animated: false)
    }
    
}

