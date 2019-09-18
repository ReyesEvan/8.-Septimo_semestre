//
//  ViewController.swift
//  Luxemburgo
//
//  Created by UDLAP19 on 9/13/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var superiorView: UIView!
    @IBOutlet weak var middleView: UIButton!
    @IBOutlet weak var inferiorView: UIView!
    
    let superiorColors = [
        UIColor.red,
        UIColor.red,
        UIColor.white,
        UIColor.red,
        UIColor.black
    ]
    let middleColors = [
        UIColor.white,
        UIColor.white,
        UIColor.blue,
        UIColor.blue,
        UIColor.red
    ]
    let inferiorColors = [
        UIColor.blue,
        UIColor.red,
        UIColor.red,
        UIColor.yellow,
        UIColor.yellow
    ]
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeFlag(_ sender: Any) {
        superiorView.backgroundColor = superiorColors[counter % superiorColors.count]
        middleView.backgroundColor = middleColors[counter % middleColors.count]
        inferiorView.backgroundColor = inferiorColors[counter % inferiorColors.count]
        counter += 1
    }
    
}

