//
//  Learning.swift
//  Camera Simulator
//
//  Created by Rasyid Ridla on 15/05/22.
//

import Foundation
import UIKit

struct Learning {
    var learningTitle: String
    var learningDesc: String
    var learningImg: String
    var learningAnim: String
    
}

extension Learning {
    static func dataLearning() -> [Learning] {
        return [
            Learning(learningTitle: "ISO", learningDesc: "ISO determines how sensitive a digital camera’s sensor is to light and ETCam is here to help you try them out in Day event.", learningImg: "isoIcon", learningAnim: "ISO determines how sensitive a digital camera’s sensor is to light and ETCam is here to help you try them out in Night event."),
//            Learning(learningTitle: "EV", learningDesc: "EV is the number that represents the light in front of your camera.\n\nExposure value (EV) in photography is a number that combines aperture and shutter speed. It represents how much light is in the scene and tells you what settings will give you the right exposure.\n\nExposure value has its roots in film photography. Photographers used a light meter or their personal experience to assess how much light was in the scene.", learningImg: "ic_ev_cell", learningAnim: "anim_EV"),
            Learning(learningTitle: "Shutter Speed", learningDesc: "Shutter speed controls how long the sensor of the camera is exposed to light, measured in fractions of a second.", learningImg: "shutterIcon", learningAnim: "shutterIcon"),
            Learning(learningTitle: "Focus", learningDesc: "Focus cameras can make adjustments for the correct exposure and correct focus and make the photographs perfect.", learningImg: "focusIcon", learningAnim: "focusIcon"),
            Learning(learningTitle: "Grid", learningDesc: "Grid lines are used so that you can actually get a perfect composition of a picture and Symmetri Grid it has two halves which are exactly the same, except that one half is the mirror image of the other. ", learningImg: "gridIcon", learningAnim: "gridIcon")
        ]
    }
}
