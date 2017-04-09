//
//  TimedMergeSorter.swift
//  491ECormackAssn1
//
//  Created by Eric Cormack on 4/7/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import UIKit

class TimedMergeSorter: TimedSorter {
    var interval: useconds_t
    unowned var barView: BarView
    var isSorting: Bool = false
    var title = "Merge"
    
    required init(barView view: inout BarView, interval deltaT: useconds_t) {
        interval = deltaT
        barView = view
    }
    
    func sort() {
        isSorting = true
        split(a: &barView.bars, low: 0, high: barView.bars.count)
        isSorting = false
    }
    
    func split<T>(a: inout [T], low: Int, high: Int) where T: Comparable {
        guard high - low >= 2 else { return }
        
        let mid = (low + high) / 2
        
        //  Split bottom and top
        split(a: &a, low: low, high: mid)
        split(a: &a, low: mid, high: high)
        
        //  Merge bottom and top together
        merge(a: &a, low: low, mid: mid, high: high)
        
    }
    
    func merge<T>(a: inout [T], low: Int, mid: Int, high: Int) where T: Comparable {
        let b = a
        
        var i = low
        var j = mid
        
        for k in low..<high {
            if i < mid && (j >= high || b[i] <= b[j]) {
                a[k] = b[i]
                i += 1
                snooze()
            } else {
                a[k] = b[j]
                j += 1
                snooze()
            }
        }
    }
}
