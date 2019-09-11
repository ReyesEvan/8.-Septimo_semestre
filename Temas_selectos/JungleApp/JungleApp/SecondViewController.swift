//
//  SecondViewController.swift
//  JungleApp
//
//  Created by UDLAP19 on 8/30/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import UIKit
import AudioToolbox
import CoreMotion

class SecondViewController: UIViewController {

    var manager: CMMotionManager!
    
    
    @IBOutlet weak var tigerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager = CMMotionManager()
    }

    override func viewWillAppear(_ animated: Bool) {
        if manager.isAccelerometerAvailable {
            manager.accelerometerUpdateInterval = 0.3
            manager.startAccelerometerUpdates(to: OperationQueue.main) {
                (data, error) in
                if let accelerometerData = self.manager.accelerometerData {
                    self.update(data: accelerometerData)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.manager.stopAccelerometerUpdates()
    }

    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        SystemSoundID.playFileNamed("tiger", withExtension: "mp3")
    }
    
    func update(data: CMAccelerometerData) {
        let deltax = CGFloat((data.acceleration.x) * 5)
        let deltay = CGFloat((data.acceleration.y) * 5)
        let x = self.tigerImage.frame.origin.x
        let y = self.tigerImage.frame.origin.y
        let newPosition = CGPoint(x: x + deltax, y: y - deltay)
        self.tigerImage.frame = CGRect(origin: newPosition, size: self.tigerImage.frame.size)
    }
}

