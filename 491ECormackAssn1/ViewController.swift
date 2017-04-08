//
//  ViewController.swift
//  491ECormackAssn1
//
//  Created by Cormack on 4/4/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static let INTERVAL: useconds_t = 30
    
    @IBOutlet var barViews: [BarView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for var barView in barViews {
            barView.sorter = TimedQuickSorter(barView: &barView, interval: ViewController.INTERVAL)
            barView.backgroundColor = UIColor.clear
            barView.shuffle()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setCount(_ sender: UISegmentedControl) {
        if let title = sender.titleForSegment(at: sender.selectedSegmentIndex),
            let newCount = Int(title) {
            for barView in barViews { barView.count = newCount }
        }
    }

    @IBAction func suffleBars(_ sender: UIButton) {
        for barView in barViews { barView.shuffle() }
    }
    
    @IBAction func sortBars(_ sender: UIButton) {
        for barView in barViews {
            DispatchQueue.global().async {
                barView.sorter?.sort()
            }
        }
    }
}

