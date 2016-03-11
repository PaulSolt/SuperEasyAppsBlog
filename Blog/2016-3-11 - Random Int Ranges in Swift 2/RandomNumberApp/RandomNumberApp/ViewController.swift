//
//  ViewController.swift
//  RandomNumberApp
//
//  Created by Paul Solt on 3/11/16.
//  Copyright © 2016 Super Easy Apps LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var outputLabel: UILabel!
	
	@IBOutlet weak var startTextField: UITextField!
	@IBOutlet weak var endTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		startTextField.text = "50"
		endTextField.text = "100"
	}
	
	
	@IBAction func randomIntButtonPressed(sender: AnyObject) {
		
		guard let start = Int(startTextField.text!) else {
			return
		}
		guard let end = Int(endTextField.text!) else {
			return
		}
		
		outputLabel.text = String(Int.randomIntFrom(start, to:end))
	}
}

