//
//  FourthViewController.swift
//  JungleApp
//
//  Created by UDLAP19 on 9/9/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class FourthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if let view = sender.view {
            let image = view as! UIImageView
            var x = image.frame.origin.x
            var y = image.frame.origin.y
            
            switch sender.direction {
                case .left:
                    x -= 100.0
                    break
                case .right:
                    x += 100.0
                    break
                case .up:
                    y -= 200.0
                    break
                case .down:
                    y += 200.0
                    break
                default:
                    break
            }
            
            let position = CGPoint(x: x, y: y)
            view.frame = CGRect(x: position.x, y: position.y, width: image.frame.size.width, height: image.frame.size.height)
            SystemSoundID.playFileNamed("trex", withExtension: "mp3")
        }
    }
    
}
