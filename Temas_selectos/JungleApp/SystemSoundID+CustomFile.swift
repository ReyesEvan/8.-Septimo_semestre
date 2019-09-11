//
//  SystemSoundID+CustomFile.swift
//  JungleApp
//
//  Created by UDLAP19 on 9/9/19.
//  Copyright © 2019 UDLAP19. All rights reserved.
//

import Foundation
import AudioToolbox

extension SystemSoundID {
    static func playFileNamed(_ fileName: String, withExtension fileExtension: String) {
        var sound: SystemSoundID = 0
        if let soundURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &sound)
            AudioServicesPlaySystemSound(sound)
        }
    }
}
