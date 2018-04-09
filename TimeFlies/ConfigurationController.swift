//
//  Configuration.swift
//  TimeFlies
//
//  Created by Vergil Choi on 2018/4/9.
//  Copyright © 2018 Vergil Choi. All rights reserved.
//

import Cocoa

class ConfigurationController: NSWindowController {
    
//    init(frame: NSRect, isPreview: Bool) {
//        super.init(window: nil)
//        
//        Bundle.main.loadNibNamed(windowNibName, owner: self, topLevelObjects: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
    override var windowNibName: NSNib.Name {
        return NSNib.Name("Configuration")
    }

    
    @IBAction func close(_ sender: Any) {
        if let window = window {
            window.sheetParent?.endSheet(window)
        }
    }
}
