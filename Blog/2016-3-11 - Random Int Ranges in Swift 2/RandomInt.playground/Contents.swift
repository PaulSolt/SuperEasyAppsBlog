//: Random Int numbers and Ranges in Swift
//: 
//: * Paul Solt
//: * 3-11-16
//: * Swift 2.1
//: * Super Easy Apps
//: * <http://SuperEasyApps.com>

import UIKit


let A: UInt32 = 10  // UInt32 = 32-bit positive integers (unsigned)
let B: UInt32 = 20
let number = arc4random_uniform(B - A + 1) + A

// Using the equation (100 - 0 + 1) + 0 becomes (101) + 0
let number1 = arc4random_uniform(101) // [0, 100]

// Using the equation (100 - 1 + 1) + 1 becomes (100) + 1
let number2 = arc4random_uniform(100) + 1 // [1, 100]

// Using the equation (100 - 50 + 1) + 50 becomes (51) + 50
let number3 = arc4random_uniform(51) + 50 // [50, 100]


// Swift Types and Functions

// Naive academic approach (good to start here)
func unsafeRandomIntFrom(start: Int, to end: Int) -> Int {
	return Int(arc4random_uniform(UInt32(end - start + 1))) + start
}

unsafeRandomIntFrom(50, to: 100)
unsafeRandomIntFrom(-50, to: 100)
//unsafeRandomIntFrom(500, to: 100) // Crash! EXC_BAD_INSTRUCTION

// This crash is because negative values are invalid for UInt32 types

// Safe random Int from range [start, end]
func randomIntFrom(start: Int, to end: Int) -> Int {
	var a = start
	var b = end
	
	// swap to prevent negative value crashes
	if a > b {
		swap(&a, &b)
	}
	return Int(arc4random_uniform(UInt32(b - a + 1))) + a
}

randomIntFrom(50, to: 100)
randomIntFrom(100, to: 50) // order shouldn't matter
randomIntFrom(4, to: 4) // only 1 value

// negative ranges work
randomIntFrom(-50, to: 100)
randomIntFrom(100, to: -50)


// One more thing ... create a reusable extension on Int for ranges



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

// Paul - Not a good solution to use Range<Int>
// ... can't prevent crash and limits of what are valid Ranges

extension Int {
	// Use Range instead of two parameters
	static func randomIntRange(range: Range<Int>) -> Int {
		var a = range.startIndex
		var b = range.endIndex
		
		// swap to prevent negative value crashes
		if a > b {
			swap(&a, &b)
		}
		return Int(arc4random_uniform(UInt32(b - a + 1))) + a
	}
}


Int.randomIntRange(-1...3)
//Int.randomIntRange(500...-1) // Syntax Error can't have ranges with -1
//Int.randomIntRange(-20... -1) // Syntax error ...
//Int.randomIntRange(500..<50)	 // Crash! EXC_BAD_INSTRUCTION


