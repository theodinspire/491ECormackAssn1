//
//  TimedInsertSorter.swift
//  491ECormackAssn1
//
//  Created by Eric Cormack on 4/7/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import UIKit

class TimedInsertSorter: TimedSorter {
    var interval: useconds_t
    unowned var barView: BarView
    var isSorting = false
    var title = "Insert"
    
    required init(barView view: inout BarView, interval deltaT: useconds_t) {
        interval = deltaT
        barView = view
    }
    
    func sort() {
        isSorting = true
        for i in 0..<barView.bars.count {
            var j = i
            while j > 0 && barView.bars[j - 1] > barView.bars[j] {
                swapAndSnooze(&barView.bars[j - 1], &barView.bars[j])
                j -= 1
            }
        }
        isSorting = false
    }
}
