//
//  ViewController.swift
//  NavigationExample
//
//  Created by UDLAP19 on 9/18/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func goToSecondView(_ sender: UIButton) {
        performSegue(withIdentifier: "showSecond", sender: self)
    }
    
}

