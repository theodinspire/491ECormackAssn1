//
//  ViewController.swift
//  491ECormackAssn1
//
//  Created by Cormack on 4/4/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static let INTERVAL: useconds_t = 33_333
    
    @IBOutlet var barViews: [BarView]!
    @IBOutlet var sortControls: [UISegmentedControl]!
    @IBOutlet weak var sortButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for (i, var barView) in barViews.enumerated() {
            barView.sorter = sorterOf(title: sortControls[i].titleForSelectedControl, barView: &barView, interval: ViewController.INTERVAL)
            barView.backgroundColor = UIColor.clear
            barView.shuffle()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setCount(_ sender: UISegmentedControl) {
        //  Prevent selection while sorting
        for barView in barViews {
            if (barView.sorter?.isSorting)! {
                for i in 0 ..< sender.numberOfSegments {
                    if let title = sender.titleForSegment(at: i),
                        let number = Int(title),
                        number == barView.count {
                        sender.selectedSegmentIndex = i
                    }
                }
                return
            }
        }
        
        //  Make selection
        if let title = sender.titleForSelectedControl,
            let newCount = Int(title) {
            for barView in barViews { barView.count = newCount }
        }
        
        sortButton.isEnabled = true
    }

    @IBAction func suffleBars(_ sender: UIButton) {
        for barView in barViews { if (barView.sorter?.isSorting)! { return } }
        
        sortButton.isEnabled = true
        
        for barView in barViews { barView.shuffle() }
    }
    
    @IBAction func sortBars(_ sender: UIButton) {
        sender.isEnabled = false
        
        for barView in barViews {
            DispatchQueue.global().async {
                barView.sorter?.sort()
            }
        }
    }
    
    @IBAction func changeSort(_ sender: UISegmentedControl) {
        //  Prevent selection while sorting
        guard let index = sortControls.index(of: sender) else { return }
        
        var barView = barViews[index]
        
        if (barView.sorter?.isSorting)! {
            for i in 0 ..< sender.numberOfSegments {
                if sender.titleForSegment(at: i) == barView.sorter?.title {
                    sender.selectedSegmentIndex = i
                    return
                }
            }
        }
        
        barView.sorter = sorterOf(title: sender.titleForSelectedControl, barView: &barView, interval: ViewController.INTERVAL)
    }
    
    func sorterOf(title type: String?, barView: inout BarView, interval: useconds_t) -> TimedSorter? {
        guard let title = type else { return nil }
        
        switch title.lowercased() {
        case "insert":
            return TimedInsertSorter(barView: &barView, interval: interval)
        case "bubble":
            return TimedBubbleSorter(barView: &barView, interval: interval)
        case "merge":
            return TimedMergeSorter(barView: &barView, interval: interval)
        case "quick":
            return TimedQuickSorter(barView: &barView, interval: interval)
        default:
            return nil
        }
    }
}

