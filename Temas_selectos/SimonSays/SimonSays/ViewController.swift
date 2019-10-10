//
//  ViewController.swift
//  SimonSays
//
//  Created by UDLAP19 on 10/7/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var streakCount: UILabel!
    @IBOutlet weak var blue: UILabel!
    @IBOutlet weak var pink: UILabel!
    @IBOutlet weak var orange: UILabel!
    @IBOutlet weak var green: UILabel!
    
    var userTurn = false
    var array = [Int]()
    var count = 0
    var audioPlayer = AVAudioPlayer()
    
    let blueSound = Bundle.main.path(forResource: "blue", ofType: "mp3")
    let pinkSound = Bundle.main.path(forResource: "pink", ofType: "mp3")
    let orangeSound = Bundle.main.path(forResource: "orange", ofType: "mp3")
    let greenSound = Bundle.main.path(forResource: "green", ofType: "mp3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func start(_ sender: Any) {
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
    }
    
    func flashAndPlay(number: Int) {
        var url: URL!
        switch number {
        case 0: UIView.animate(withDuration: 1, animations: {
            self.blue.alpha = 0.5
            self.blue.alpha = 1
            })
            url = URL(fileURLWithPath: blueSound!)
        case 1: UIView.animate(withDuration: 1, animations: {
            self.pink.alpha = 0.5
            self.pink.alpha = 1
        })
            url = URL(fileURLWithPath: blueSound!)
            
        case 2: UIView.animate(withDuration: 1, animations: {
            self.orange.alpha = 0.5
            self.orange.alpha = 1
        })
            url = URL(fileURLWithPath: blueSound!)
        case 3: UIView.animate(withDuration: 1, animations: {
            self.green.alpha = 0.5
            self.green.alpha = 1
        })
            url = URL(fileURLWithPath: blueSound!)
        default: UIView.animate(withDuration: 1, animations: {
            self.blue.alpha = 0.5
            self.blue.alpha = 1
        })
            url = URL(fileURLWithPath: blueSound!)
        }
    }
    
}

