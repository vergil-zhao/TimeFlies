//
//  TimeFliesView.swift
//  TimeFlies
//
//  Created by Vergil Choi on 2018/4/9.
//  Copyright © 2018 Vergil Choi. All rights reserved.
//

import AppKit
import ScreenSaver

class TimeFliesView: ScreenSaverView {
    
    private let percentNumber: NSTextField = {
        let view = NSTextField(labelWithString: "Hello World")
        view.textColor = .white
        return view
    }()
    
    private let percentLabel: NSTextField = {
        let view = NSTextField(labelWithString: "of this year has passed.")
        view.textColor = .white
        return view
    }()

    
    convenience init() {
        self.init(frame: NSRect.zero, isPreview: false)
    }
    
    override init!(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        prepareForDisplay()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        prepareForDisplay()
    }
    
//    private lazy var configuration = {
//        return ConfigurationController()
//    }()
//
//    override var hasConfigureSheet: Bool {
//        return true
//    }
//
//    override var configureSheet: NSWindow? {
//        return configuration.window
//    }
    
    override func animateOneFrame() {
        update()
    }
    
    private func prepareForDisplay() {
        update()
        addSubview(percentNumber)
        addSubview(percentLabel)
    }
    
    private func update() {
        percentNumber.stringValue = String(format: "%.6f %%", remainPercentOfYear())
        
        percentNumber.font = NSFont.monospacedDigitSystemFont(ofSize: bounds.height * 0.2, weight: NSFont.Weight.ultraLight)
        percentNumber.sizeToFit()
        percentNumber.frame.origin.x = bounds.width / 2 - percentNumber.frame.width / 2
        percentNumber.frame.origin.y = bounds.height / 2 - percentNumber.frame.height / 2
        
        percentLabel.font = NSFont.systemFont(ofSize: bounds.height * 0.02, weight: NSFont.Weight.semibold)
        percentLabel.sizeToFit()
        percentLabel.frame.origin.x = bounds.width / 2 - percentLabel.frame.width / 2
        percentLabel.frame.origin.y = percentNumber.frame.origin.y - percentLabel.frame.height
        
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        NSColor.black.setFill()
        dirtyRect.fill()
    }
    
    private func remainPercentOfYear() -> Double {
        
        let calendar = Calendar.current
        let now = Date()
        let yearComponent = calendar.dateComponents([.year], from: now)
        let thisYear = calendar.date(from: yearComponent)!
        
        let passed = abs(thisYear.timeIntervalSinceNow)
        
        let longComponent = DateComponents(calendar: calendar, timeZone: nil, era: nil, year: yearComponent.year! + 1, month: nil, day: nil, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        let longOfThisYear = calendar.date(from: longComponent)!.timeIntervalSinceNow + passed
        
        return passed / longOfThisYear * 100
    }
    
    
}
