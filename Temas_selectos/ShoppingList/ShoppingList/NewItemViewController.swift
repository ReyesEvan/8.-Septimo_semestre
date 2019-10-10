//
//  NewItemViewController.swift
//  ShoppingList
//
//  Created by UDLAP19 on 9/23/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import Foundation
import UIKit

class NewItemViewController: UIViewController {
    var items =  ["milk", "bread", "eggs", "grapes", "pizza", "tomatoes", "cheese"]
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    
    @IBAction func saveItem(_ sender: Any) {
        performSegue(withIdentifier: "saveItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ViewController
        destination.addItem(item: items[pickerView.selectedRow(inComponent: 0)])
        
    }
}

extension NewItemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    
}

extension NewItemViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
}
