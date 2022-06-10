//
//  ThirdViewController.swift
//  ToolCollection_Example
//
//  Created by mac on 2020/1/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import ToolCollection

class ThirdViewController: UIViewController {
    
    //MARK: UIViewController 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func shouldPopViewControllerByBackButtonOrPopGesture(_ byPopGesture: Bool) -> Bool {
        print("byPopGesture", byPopGesture)
        return false
    }
}

private extension ThirdViewController {
    func setupUI() {
        title = "can't pop"
        view.backgroundColor = .white
    }

    func setupData() {
//        let manager = Typist.shared
        
//        let label = UILabel()
        
        let stack = VStackView {
            UIView()
            (0 ..< 10).map { _ in UIView() }
            UIButton()
        }
        
        view.addSubview(stack)
    }
}

