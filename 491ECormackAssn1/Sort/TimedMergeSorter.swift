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
    
    required init(barView view: inout BarView, interval deltaT: useconds_t) {
        interval = deltaT
        barView = view
    }
    
    func sort() {
        //quickSort(low: 0, high: barView.bars.count - 1)
    }
}
