//
//  SecondViewController.swift
//  ToolCollection_Example
//
//  Created by mac on 2020/1/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import ToolCollection

class SecondViewController: UIViewController {
    
    let stackView = AloeStackView()
    
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
        return true
    }
}

private extension SecondViewController {
    func setupUI() {
        title = "canPop"
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        stackView.frame = .init(x: 0, y: 100, width: 375, height: 200)
        stackView.backgroundColor = .purple
    }
    
    func setupData() {
        
        
    }
}
