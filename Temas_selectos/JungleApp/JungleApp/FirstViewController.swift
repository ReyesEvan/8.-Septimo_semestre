//
//  FirstViewController.swift
//  JungleApp
//
//  Created by UDLAP19 on 8/30/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import UIKit
import AudioToolbox

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
            SystemSoundID.playFileNamed("cock", withExtension: "mp3")
        }
    }
}

