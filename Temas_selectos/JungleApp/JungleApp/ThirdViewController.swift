//
//  ThirdViewController.swift
//  JungleApp
//
//  Created by UDLAP19 on 9/9/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func handlePinch(_ sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
            SystemSoundID.playFileNamed("quack", withExtension: "mp3")
        }
    }
}
