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
        view.backgroundColor = .dynamicColor(light: .white, dark: .black)
        
//        addButtonNode()
        
//        testButton()
//        textGhostButton()
//        testLinkButton()
//
        textasd()
//
//        addAttributeLabel()
    }

    let japanServer = ["JP"]
    
    let chinaServer = ["CN"]
    
    let europeServer = ["GB"]
    
    func textasd() {
        print(DemoPropertyWrapper.notes ?? "nil")
        
        DemoPropertyWrapper.notes = [Note(time: Date(), content: "first day")]
        
        print(DemoPropertyWrapper.notes ?? "nil")
        
        DemoPropertyWrapper.notes?.append(Note(time: Date().addingTimeInterval(1), content: "second day"))
        
        print(DemoPropertyWrapper.notes ?? "nil")
//        print(DemoPropertyWrapper.stringArray)
//        DemoPropertyWrapper.stringArray = ["1098", "12321"]
//        print(DemoPropertyWrapper.stringArray)
//
//        DemoPropertyWrapper.stringArray = ["123321", "1235555"]
//
//        print(DemoPropertyWrapper.stringArray)
//
//
//        DemoPropertyWrapper.optionalInt = nil
//        print(DemoPropertyWrapper.optionalInt ?? "")
//        DemoPropertyWrapper.optionalInt = 120
//        print(DemoPropertyWrapper.optionalInt ?? "")
//        DemoPropertyWrapper.optionalInt = 140
//        print(DemoPropertyWrapper.optionalInt ?? "")
//
//        print(DemoPropertyWrapper.int)
//        DemoPropertyWrapper.int = 2
//        print(DemoPropertyWrapper.int)
//        DemoPropertyWrapper.int += 3
//        print(DemoPropertyWrapper.int)
//        DemoPropertyWrapper.int += 12
//        print(DemoPropertyWrapper.int)
//
//        print(DemoPropertyWrapper.optionalData ?? "nil")
//        DemoPropertyWrapper.optionalData = "optionalData".data(using: .utf8)
//        print(DemoPropertyWrapper.optionalData ?? "nil")
//        if let data = DemoPropertyWrapper.optionalData {
//            print(String(data: data, encoding: .utf8) ?? "")
//        }
    }
    
    func addButtonNode() {
        let node = SettingSwitchNode()
        view.addSubview(node)
        node.sizeToFit()
        
        node.center = UIScreen.main.bounds.center
    }
    
    func testButton() {
        let button = SKFillButton(fillColor: .blue, titleTextColor: .white)
//        button.backgroundColor = .blue
        
        button.disableBackgroundColor = .cyan
        
        button.setTitle("fill", for: .normal)
        button.contentEdgeInsets = .init(top: 5, left: 20, bottom: 5, right: 20)
        view.addSubview(button)
        
        button.sizeToFit()
        button.center = UIScreen.main.bounds.center
        
        button.addTarget(self, action: #selector(someButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func someButtonTapped(_ button: UIButton) {
        button.isEnabled.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            button.isEnabled.toggle()
        }
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
        
    }
    
    func addAttributeLabel() {
        let label = SKAttributedLabel()
        if #available(iOS 13.0, *) {
            label.attributedText = "attribute".attributedString().font(.systemFont(ofSize: 15)).textColor(UIColor.dynamicColor(light: .black, dark: .white))
        } else {
            // Fallback on earlier versions
        }
        
        view.addSubview(label)
        
        label.sizeToFit()
        
        var point = UIScreen.main.bounds.center
        point.y = point.y + 100
        label.center = point
        
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
    
    @OptionalMMKVProperty(key: "str")
    static var str: String?
    
    @OptionalMMKVProperty(key: "optionalInt")
    static var optionalInt: Int?
    
    @MMKVProperty(key: "int", defaultValue: 1)
    static var int: Int
    
    @OptionalMMKVProperty(key: "asd")
    static var optionalData: Data?
    
    @OptionalMMKVProperty(key: "optionstringArray")
    static var optionalStringArray: [String]?
    
    @MMKVProperty(key: "stringArray", defaultValue: [])
    static var stringArray: [String]
    
    @OptionalMMKVProperty(key: "com.notes")
    static var notes: [Note]?
}

struct Note: Codable {
    let time: Date
    let content: String
}

extension UIColor {
    class func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            let color = UIColor { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return dark
                }
                return light
            }
            return color
        } else {
            return light
        }
    }
}
