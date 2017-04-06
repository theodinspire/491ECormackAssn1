//
//  StackView.swift
//  491ECormackAssn1
//
//  Created by Eric Cormack on 4/5/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import UIKit

class StackView: UIView {
    //  Regular properties
    var count: Int = 16 {
        didSet { if count != oldValue { shuffle() } }
    }
    var stacks: [CGFloat] = []
    
    //  Inspectable properties
    @IBInspectable var stackColor: UIColor = UIColor.darkGray
    
    //  UIView methods

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard stacks.count != 0 else { return }
        
        let delta = rect.size.width / CGFloat(stacks.count)
        let offset = delta / 2
        let stackWidth = delta - 1
        
        stackColor.setStroke()
        
        for (i, stack) in stacks.enumerated() {
            let x = CGFloat(i) * delta + offset
            
            let path = UIBezierPath()
            path.lineWidth = stackWidth
            
            path.move(to: CGPoint(x: x, y: rect.height - stack))
            path.addLine(to: CGPoint(x: x, y: rect.height))
            
            path.stroke()
        }
    }

    //  Methods
    func shuffle() {
        stacks.removeAll(keepingCapacity: true)
        stacks.reserveCapacity(count)
        for i in 0..<count {
            stacks.append(bounds.size.height * CGFloat(1 + i) / CGFloat(count))
        }
        
        //stacks.shuffle()
        
        setNeedsDisplay()
    }
    
    //  **SORTS**
    //  Quicksort
    func quickSort() {
        StackView.quikSort(&stacks, low: 0, high: stacks.count - 1)
    }
    
    private static func quikSort<T>(_ array: inout [T], low: Int, high: Int) where T: Comparable {
        if low < high {
            let p = qSPartition(&array, low: low, high: high)
            quikSort(&array, low: low,   high: p - 1)
            quikSort(&array, low: p + 1, high: high)
        }
    }
    
    private static func qSPartition<T>(_ array: inout [T], low: Int, high: Int) -> Int where T: Comparable {
        let pivot = array[high]
        var i = low - 1
        
        for j in low..<high {
            if array[j] <= pivot {
                i += 1
                swap(&array[i], &array[j])
            }
        }
        
        i += 1
        swap(&array[i], &array[high])
        
        return i;
    }
}
