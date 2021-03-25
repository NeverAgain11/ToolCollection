//
//  SKTappableView.swift
//  ToolCollection
//
//  Created by Endless Summer on 2021/3/25.
//

import Foundation
import UIKit

open class SKTappableView: UIView {
    
    // MARK: Lifecycle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            insetsLayoutMarginsFromSafeArea = false
        }
        
        setUpTapGestureRecognizer()
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    
    open func configure() {
        
    }
    
    // MARK: UIResponder
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard isUserInteractionEnabled else { return }
        
        setIsHighlighted(true)
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard isUserInteractionEnabled, let touch = touches.first else { return }
        
        let locationInSelf = touch.location(in: self)
        
        let isPointInsideCell = point(inside: locationInSelf, with: event)
        setIsHighlighted(isPointInsideCell)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        guard isUserInteractionEnabled else { return }
        
        setIsHighlighted(false)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard isUserInteractionEnabled else { return }
        
        setIsHighlighted(false)
    }
    
    // MARK: Internal
    
    public var tapHandler: ((UIView) -> Void)? {
        didSet { updateTapGestureRecognizerEnabled() }
    }
    
    private let tapGestureRecognizer = UITapGestureRecognizer()
    
    private func setUpTapGestureRecognizer() {
        tapGestureRecognizer.addTarget(self, action: #selector(handleTap(_:)))
        tapGestureRecognizer.delegate = self
        addGestureRecognizer(tapGestureRecognizer)
        updateTapGestureRecognizerEnabled()
    }
    
    @objc private func handleTap(_ tapGestureRecognizer: UITapGestureRecognizer) {
        guard isUserInteractionEnabled else { return }
        tapHandler?(self)
    }
    
    private func updateTapGestureRecognizerEnabled() {
        tapGestureRecognizer.isEnabled = tapHandler != nil
    }
    
    func setIsHighlighted(_ isHighlighted: Bool) {
        alpha = isHighlighted ? 0.5 : 1
    }

}

extension SKTappableView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let view = gestureRecognizer.view else { return false }
        
        let location = touch.location(in: view)
        var hitView = view.hitTest(location, with: nil)
        
        // Traverse the chain of superviews looking for any UIControls.
        while hitView != view && hitView != nil {
            if hitView is UIControl {
                // Ensure UIControls get the touches instead of the tap gesture.
                return false
            }
            hitView = hitView?.superview
        }
        
        return true
    }
    
}
