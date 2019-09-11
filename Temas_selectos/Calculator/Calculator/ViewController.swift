//
//  ViewController.swift
//  Calculator
//
//  Created by UDLAP19 on 9/5/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var temp = 0
    var operation = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func handleNumber(_ sender: UIButton) {
        if operation == "=" {
            label.text = ""
            operation = ""
        }
        label.text = label.text! + sender.titleLabel!.text!
    }
    
    @IBAction func clear(_ sender: UIButton) {
        label.text = ""
        temp = 0
        operation = ""
    }
    
    @IBAction func handleOperation(_ sender: UIButton) {
        temp = Int(label.text!)!
        operation = sender.titleLabel!.text!
        label.text = ""
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        let number = Int(label.text!)!
        var total = 0
        
        switch (operation) {
        case "+":
            total = temp + number
            break
        case "-":
            total = temp - number
            break
        case "*":
            total = temp * number
        case "/":
            total = temp / number
        default:
            print("nel")
        }
        label.text = String(total)
        temp = total
        operation = "="
    }
    
}

