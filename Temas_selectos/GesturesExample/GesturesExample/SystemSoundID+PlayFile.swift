//
//  SystemSoundID+PlayFile.swift
//  GesturesExample
//
//  Created by UDLAP19 on 8/23/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import Foundation
import AudioToolbox

extension SystemSoundID {
    static func playFile(_ name: String, withExtension ext: String) {
        var sound: SystemSoundID = 0
        if let soundURL = Bundle.main.url(forResource: name, withExtension: ext) {
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &sound)
            AudioServicesPlaySystemSound(sound)
        }
    }
}
