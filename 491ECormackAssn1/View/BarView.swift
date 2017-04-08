//
//  BarView.swift
//  491ECormackAssn1
//
//  Created by Eric Cormack on 4/5/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import UIKit

class BarView: UIView {
    //  Regular properties
    var count: Int = 16 {
        didSet { if count != oldValue { shuffle() } }
    }
    var bars: [CGFloat] = []
    
    var sorter: TimedSorter?
    
    //  Inspectable properties
    @IBInspectable var barColor: UIColor = UIColor.darkGray
    
    //  UIView methods

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard bars.count != 0 else { return }
        
        let delta = rect.size.width / CGFloat(bars.count)
        let offset = delta / 2
        let barWidth = delta - 1
        
        barColor.setStroke()
        
        for (i, bar) in bars.enumerated() {
            let x = CGFloat(i) * delta + offset
            
            let path = UIBezierPath()
            path.lineWidth = barWidth
            
            path.move(to: CGPoint(x: x, y: rect.height * (1 - bar)))
            path.addLine(to: CGPoint(x: x, y: rect.height))
            
            path.stroke()
        }
    }

    //  Methods
    func shuffle() {
        if bars.count != count {
            bars.removeAll(keepingCapacity: true)
            for i in 0..<count {
                bars.append(CGFloat(1 + i) / CGFloat(count))
            }
        }
        
        bars.shuffle()
        
        setNeedsDisplay()
    }
}
