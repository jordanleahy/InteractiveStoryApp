//
//  Audio.swift
//  InterActiveStoryApp
//
//  Created by Jordan Leahy on 7/6/18.
//  Copyright © 2018 Jordan Leahy. All rights reserved.
//

import Foundation
import AudioToolbox

extension Story {
    
    var soundEffectName: String {
        switch self {
        case .droid, .home: return "HappyEnding"
        case .monster: return "Ominous"
        default: return "PageTurn"
        }
    }
    
    var soundEffectURL: URL { //computed property
        let path = Bundle.main.path(forResource: soundEffectName, ofType: "wav")!
        return URL(fileURLWithPath: path)
    }
}

class SoundEffectsPlayer {
    var sound: SystemSoundID = 0 //This property stores the sound that we want to play
    
    func playSound(for story: Story) {
        let soundURL = story.soundEffectURL as CFURL
        AudioServicesCreateSystemSoundID(soundURL, &sound)
        AudioServicesPlaySystemSound(sound)
    }
}


























