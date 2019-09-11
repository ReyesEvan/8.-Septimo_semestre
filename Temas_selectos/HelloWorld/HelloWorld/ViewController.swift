//
//  ViewController.swift
//  HelloWorld
//
//  Created by UDLAP19 on 8/12/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblHelloWorld: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func greet(_ sender: Any) {
        if textField.text!.isEmpty {
            lblHelloWorld.text = "What's your name?"
        }
        else {
            lblHelloWorld.text = "Hello" + textField.text! + "!"
        }
    }
    
}

