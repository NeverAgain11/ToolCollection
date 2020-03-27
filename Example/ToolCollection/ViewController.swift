//
//  ViewController.swift
//  ToolCollection
//
//  Created by ljk on 07/09/2018.
//  Copyright (c) 2018 ljk. All rights reserved.
//

import UIKit
import MMKV
import ToolCollection

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
//            view.backgroundColor = .systemBackground
        }
        view.backgroundColor = .white
        // Do any additional setup after loading the view, typically from a nib.
        
//        let code = NSLocale.current.regionCode ?? ""
//        let regionName = NSLocale.current.localizedString(forRegionCode: code) ?? ""
        
//        let timer = SwiftCountDownTimer(interval: .fromSeconds(10), times: 1, queue: .main) { (_, time) in
//            print(time)
//        }
//        timer.start()
//
//        let countryArray = NSLocale.isoCountryCodes
//        for counrtyCode in countryArray {
//            let locale = Locale(identifier: "zh_Hans_CN")
//
//            let displayName = locale.localizedString(forRegionCode: counrtyCode) ?? ""
//            print(displayName, " :", counrtyCode)
//        }
        
        testButton()
        textGhostButton()
        testLinkButton()
        
        textasd()
    }

    let japanServer = ["JP"]
    
    let chinaServer = ["CN"]
    
    let europeServer = ["GB"]
    
    func textasd() {
//        let cellModel = SKCollectionCellModel<YHCollectionCell>()
        
        print(DemoPropertyWrapper.int)
        DemoPropertyWrapper.int = 110
        print(DemoPropertyWrapper.int)
        
//        DemoPropertyWrapper.optionalInt = nil
//        print(DemoPropertyWrapper.optionalInt ?? "")
//        DemoPropertyWrapper.optionalInt = 120
//        print(DemoPropertyWrapper.optionalInt ?? "")
//        DemoPropertyWrapper.optionalInt = 140
//        print(DemoPropertyWrapper.optionalInt ?? "")
        
        
    }
    
    func addButtonNode() {
        
    }
    
    func testButton() {
        let button = SKFillButton(fillColor: .purple, titleTextColor: .white)
        button.setTitle("fill", for: .normal)
        button.contentEdgeInsets = .init(top: 5, left: 20, bottom: 5, right: 20)
        view.addSubview(button)
        
        button.sizeToFit()
        button.center = UIScreen.main.bounds.center
        
    }
    
    func textGhostButton() {
        let button = SKGhostButton()
        button.ghostColor = .cyan
        button.frame = .init(x: 0, y: 0, width: 70, height: 30)
        button.setTitle("ghost", for: .normal)
        button.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        view.addSubview(button)
        
        var point = UIScreen.main.bounds.center
        point.y = point.y + 50
        button.center = point
//
    }
    
    func testLinkButton() {
        let button = SKLinkButton(title: "underLine", image: nil)
//        button.underlineColor = .darkText
        button.setTitleColor(.darkText, for: .normal)
        button.addTarget(self, action: #selector(thirdButtonTapped), for: .touchUpInside)
        button.setTitle("ghost", for: .normal)
        view.addSubview(button)
        
        button.sizeToFit()
        var point = UIScreen.main.bounds.center
        point.y = point.y + 150
        button.center = point
    }
    
    @objc func secondButtonTapped() {
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func thirdButtonTapped() {
        let vc = ThirdViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

struct DemoPropertyWrapper {
    @MMKVProperty(key: "int32", defaultValue: 43)
    static var int32: Int32
    
//    @OptionalMMKVProperty(key: "str")
//    static var str: String?
    
//    @OptionalMMKVProperty(key: "optionalInt")
//    static var optionalInt: Int?
    
    @MMKVProperty(key: "int", defaultValue: 1)
    static var int: Int
}
