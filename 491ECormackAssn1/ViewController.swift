//
//  ViewController.swift
//  491ECormackAssn1
//
//  Created by Cormack on 4/4/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var stacks: [StackView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for stack in stacks { stack.shuffle() }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

