//
//  TimedBubbleSorter.swift
//  491ECormackAssn1
//
//  Created by Eric Cormack on 4/7/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import UIKit

class TimedBubbleSorter: TimedSorter {
    var interval: useconds_t
    unowned var barView: BarView
    var isSorting: Bool = false
    var title = "Bubble"
    
    required init(barView view: inout BarView, interval deltaT: useconds_t) {
        interval = deltaT
        barView = view
    }
    
    func sort() {
        isSorting = true
        var hasSwapped = true
        while hasSwapped {
            hasSwapped = false
            for i in 1 ..< barView.bars.count {
                if barView.bars[i - 1] > barView.bars[i] {
                    hasSwapped = true
                    swapAndSnooze(&barView.bars[i - 1], &barView.bars[i])
                }
            }
        }
        isSorting = false
    }
}
