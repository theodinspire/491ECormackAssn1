//
//  TimedSorter.swift
//  491ECormackAssn1
//
//  Created by Eric Cormack on 4/7/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import Foundation

protocol TimedSorter {
    var interval: useconds_t { get }
    unowned var barView: BarView { get }
    var isSorting: Bool { get }
    var title: String { get }
    
    init(barView view: inout BarView, interval deltaT: useconds_t)
    
    func sort()
}

extension TimedSorter {
    func swap<T>(_ a: inout T, _ b: inout T) { (a, b) = (b, a) }
    
    func snooze() {
        DispatchQueue.main.async { self.barView.setNeedsDisplay() }
        usleep(interval)
    }
    
    func swapAndSnooze<T>(_ a: inout T, _ b: inout T) {
        (a, b) = (b, a)
        snooze()
    }
}
