//
//  ViewController.swift
//  GesturesExample
//
//  Created by UDLAP19 on 8/21/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    
    @IBOutlet weak var tapLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        SystemSoundID.playFile("beep", withExtension: "mp3")
        
        tapLabel.backgroundColor = .orange
    }
    
    @IBAction func handlePinch(_ sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
    }
    
    @IBAction func handleRotation(_ sender: UIRotationGestureRecognizer) {
        if let view = sender.view {
            view.transform = view.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        }
    }
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view) //how much did it translate in the whole view
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        sender.setTranslation(.zero, in: self.view)
    }
    
    @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if let view = sender.view {
            var x = view.center.x
            var y = view.center.y
            
            switch sender.direction {
            case .left:
                x -= 50.0
                break
            case .right:
                x += 50.0
                break
            case .up:
                y -= 50.0
                break
            case .down:
                y += 50.0
                break
            default: break
            }
            view.center = CGPoint(x: x, y: y)
        }
    }
    
    
    @IBAction func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        if let view = sender.view {
            if view.backgroundColor == .white {
                UIView.animate(withDuration: 2.0, delay: 1.0, options: [UIView.AnimationOptions.repeat, .autoreverse], animations: { view.backgroundColor = .lightGray
                })
            } else {
                UIView.animate(withDuration: 2.0, delay: 1.0, options: [UIView.AnimationOptions.repeat, .autoreverse], animations: { view.backgroundColor = .white })
            }
        }
    }
    
    
    
}

