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
        
        let timer = SwiftCountDownTimer(interval: .fromSeconds(10), times: 1, queue: .main) { (_, time) in
            print(time)
        }
        timer.start()
        
        let countryArray = NSLocale.isoCountryCodes
        for counrtyCode in countryArray {
            let locale = Locale(identifier: "zh_Hans_CN")
            
            let displayName = locale.localizedString(forRegionCode: counrtyCode) ?? ""
            print(displayName, " :", counrtyCode)
        }
        
        
        
        
    }

    let japanServer = ["JP"]
    
    let chinaServer = ["CN"]
    
    let europeServer = ["GB"]
    
    func textasd() {
//        let cellModel = JKCollectionCellModel<YHCollectionCell>()
        
        
        
    }
}

