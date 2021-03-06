# How to Create a Random Int Number in Swift 2 - Swift Tips 7 #

Good random numbers in iPhone apps are really important (the same is true for the lottery!). A good random number is from a range [start, end] that gives every value an equal probability of occurring. 

An equal probability means that if you were to flip a coin—you should always get close to 50% heads and 50% tails over 100 coin tosses.

[Download the sample Xcode project](http://courses.supereasyapps.com/courses/swift-tips/?src=RandomIntInSwift_SwiftTip7) that shows how to create random Int numbers in Swift with a working iPhone app.

## Swift Random Int Range ##

In Swift you should use the arc4random_uniform(N) function because it creates **better** random numbers (i.e.: equal probability).

`arc4random_uniform(N)` creates a number within from [0, N - 1], which means if you want numbers in the range [0, 100] you need to call `arc4random_uniform(N + 1)`. 

1. Random Int [A, B] where A < B

		let A: UInt32 = 10 // UInt32 = 32-bit positive integers (unsigned)
		let B: UInt32 = 20
		let number = arc4random_uniform(B - A + 1) + A		
		
2. Random Int [0, 100]

		// Using the equation (100 - 0 + 1) + 0 becomes (101)
		let number = arc4random_uniform(101) // [0, 100]

3. Random Int [1, 100] 

		// Using the equation (100 - 1 + 1) + 1 becomes (100) + 1
		let number2 = arc4random_uniform(100) + 1 // [1, 100]
		
4. Random Int [50, 100]

		// Using the equation (100 - 50 + 1) + 50 becomes (51) + 50
		let number3 = arc4random_uniform(51) + 50 // [50, 100]

5. **Unsafe**: Swift method for a random Int within [A, B] where A < B

	Swift is strongly-typed which means that you need to explicitly change numbers that are Int into `UInt32` and vice versa for the code to compile. Use the `Int()` and `UInt32()` initializers to convert between the types.

		func unsafeRandomIntFrom(start: Int, to end: Int) -> Int {
			return Int(arc4random_uniform(UInt32(end - start + 1))) + start
		}
		
		unsafeRandomIntFrom(50, to: 100)  // positive ascending ranges work
		unsafeRandomIntFrom(-50, to: 100) // negative ranges work!
		//unsafeRandomIntFrom(500, to: 100) // Crash! EXC_BAD_INSTRUCTION
	
	**Crash**: Technically this will crash if `A > B` with a `EXC_BAD_INSTRUCTION` because the parameter of `arc4random_uniform()` is `UInt32` and can only hold positive 32-bit integer values. 

6. **Safe** Swift method for a random Int within [A, B]

		func randomIntFrom(start: Int, to end: Int) -> Int {
			var a = start
			var b = end
			// swap to prevent negative integer crashes
			if a > b {
				swap(&a, &b)
			}
			return Int(arc4random_uniform(UInt32(b - a + 1))) + a
		}

### Int Type Extension ###

You can make the randomIntFrom(_:end:) a static function on the type Int using a static function. This code block is then reusable in any of your projects to make random number generation simple.

	extension Int {
		func randomIntFrom(start: Int, to end: Int) -> Int {
			var a = start
			var b = end
			// swap to prevent negative integer crashes
			if a > b {
				swap(&a, &b)
			}
			return Int(arc4random_uniform(UInt32(b - a + 1))) + a
		}
	}


### Where Does arc4random_uniform() Come From? ###

This random function is actually written in the C programming language (which you can use in Swift!). Read the [arc4random man page (i.e.: manual page)](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man3/arc4random_uniform.3.html) for all the details.

### Download the Code ###

[Download the sample Xcode project](http://courses.supereasyapps.com/courses/swift-tips/?src=RandomIntInSwift_SwiftTip7) that shows you how to create random Int numbers in Swift with a working iPhone app.

You can play change the range of numbers with the iPhone app to see how to use the  `arc4random_uniform()` function correctly in your own apps.