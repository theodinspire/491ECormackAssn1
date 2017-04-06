//
//  Array.swift
//  491ECormackAssn1
//
//  Created by Eric Cormack on 4/5/17.
//  Copyright © 2017 theodinspire. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        for i in (1..<self.count) {
            let j = Int(arc4random_uniform(UInt32(i)))
            (self[i], self[j]) = (self[j], self[i])
        }
    }
}
