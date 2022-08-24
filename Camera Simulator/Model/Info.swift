//
//  Info.swift
//  Camera Simulator
//
//  Created by Muhamad Arif on 23/08/22.
//

import Foundation
import UIKit

struct Info {
    var title: String
    var subtitle: String
    var image: String
    
}

extension Info {
    static func dataInfo() -> [Info] {
        return [
            Info(title: "Tell a Friend", subtitle: "Share with your friend", image: "pdftellfriend"),
            Info(title: "Rate App", subtitle: "Write comment and rate", image: "pdfrate"),
            Info(title: "Privacy Policy", subtitle: "Read document management client data", image: "pdfprivacy"),
            Info(title: "About us", subtitle: "Know us more", image: "pdfaboutus")
        ]
    }
}

