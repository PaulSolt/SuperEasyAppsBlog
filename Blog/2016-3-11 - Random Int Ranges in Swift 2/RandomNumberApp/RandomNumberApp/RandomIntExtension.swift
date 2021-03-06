//
//  RandomIntExtension.swift
//  RandomNumberApp
//
//  Created by Paul Solt on 3/11/16.
//  Copyright © 2016 Super Easy Apps LLC. All rights reserved.
//

import Foundation

extension Int {
	static func randomIntFrom(start: Int, to end: Int) -> Int {
		var a = start
		var b = end
		// swap to prevent negative integer crashes
		if a > b {
			swap(&a, &b)
		}
		return Int(arc4random_uniform(UInt32(b - a + 1))) + a
	}
}