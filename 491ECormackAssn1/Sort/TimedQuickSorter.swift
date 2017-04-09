//
//  TimedQuickSorter.swift
//  491ECormackAssn1
//
//  Created by Eric Cormack on 4/7/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import UIKit

class TimedQuickSorter: TimedSorter {
    var interval: useconds_t
    unowned var barView: BarView
    var isSorting = false
    var title = "Quick"
    
    required init(barView view: inout BarView, interval deltaT: useconds_t) {
        interval = deltaT
        barView = view
    }
    
    func sort() {
        isSorting = true
        quickSort(low: 0, high: barView.bars.count - 1)
        isSorting = false
    }
    
    private func quickSort(low: Int, high: Int) {
        if low < high {
            let p = partition(low: low, high: high)
            quickSort(low: low,   high: p - 1)
            quickSort(low: p + 1, high: high)
        }
    }
    
    private func partition(low: Int, high: Int) -> Int {
        let pivot = barView.bars[high]
        var i = low - 1
        
        for j in low..<high {
            if barView.bars[j] <= pivot {
                i += 1
                swapAndSnooze(&barView.bars[i], &barView.bars[j])
            }
        }
        
        i += 1
        swapAndSnooze(&barView.bars[i], &barView.bars[high])
        
        return i;
    }
}
