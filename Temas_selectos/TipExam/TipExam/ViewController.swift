//
//  ViewController.swift
//  TipExam
//
//  Created by UDLAP19 on 8/28/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var subtotal: UITextField!

    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var tip: UILabel!
    
    @IBOutlet weak var total: UILabel!
    
    let data = ["Poor", "Okay", "Good", "Great"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        picker.dataSource = self
        picker.delegate = self
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        var percentageStr = sender.titleLabel?.text!
        percentageStr!.removeLast()
        let percent = NumberFormatter().number(from: subtotal.text!)!.doubleValue
        if subtotal.text!.count > 0 {
            let amount = NumberFormatter().number(from: subtotal.text!)!.doubleValue
            let tipAmount = amount * percent / 100
            let totalAmount = amount + tipAmount
            tip.text = "Tip: $" + String(format: "%.2f", tipAmount)
            total.text = "Total: $" + String(format: "%.2f", totalAmount)
        }
        else {
            total.text = "Please enter a number..."
        }
    }
    
    
    @IBAction func handleTap(_ sender: Any) {
        view.endEditing(true)
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
            case 0:
                button1.setTitle("0%", for: .normal)
                button2.setTitle("10%", for: .normal)
                button3.setTitle("15%", for: .normal)
                break;
            case 1:
                button1.setTitle("10%", for: .normal)
                button2.setTitle("15%", for: .normal)
                button3.setTitle("18%", for: .normal)
                break;
            case 2:
                button1.setTitle("15%", for: .normal)
                button2.setTitle("18%", for: .normal)
                button3.setTitle("20%", for: .normal)
                break;
            default:
                button1.setTitle("18%", for: .normal)
                button2.setTitle("20%", for: .normal)
                button3.setTitle("25%", for: .normal)
                break;
        }
    }
}
