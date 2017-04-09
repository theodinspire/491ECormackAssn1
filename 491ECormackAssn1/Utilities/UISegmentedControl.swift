//
//  UISegmentedControl.swift
//  491ECormackAssn1
//
//  Created by Eric Cormack on 4/8/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    var titleForSelectedControl: String? {
        return titleForSegment(at: selectedSegmentIndex)
    }
}
