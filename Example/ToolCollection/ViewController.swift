//
//  ViewController.swift
//  ToolCollection
//
//  Created by ljk on 07/09/2018.
//  Copyright (c) 2018 ljk. All rights reserved.
//

import UIKit
import ToolCollection

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        
        textasd()
        
    }

    let japanServer = ["JP"]
    
    let chinaServer = ["CN"]
    
    let europeServer = ["GB"]
    
    func textasd() {
//        let cellModel = JKCollectionCellModel<YHCollectionCell>()
        
        print(DemoPropertyWrapper.int)
        DemoPropertyWrapper.int = 110
        print(DemoPropertyWrapper.int)
        
        print(DemoPropertyWrapper.optionalInt)
        DemoPropertyWrapper.optionalInt = 120
        print(DemoPropertyWrapper.optionalInt)
        DemoPropertyWrapper.optionalInt = 140
        print(DemoPropertyWrapper.optionalInt)
        
        
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
}
