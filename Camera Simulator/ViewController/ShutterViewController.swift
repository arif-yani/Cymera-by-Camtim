//
//  ShutterViewController.swift
//  Camera Simulator
//
//  Created by Muhamad Arif on 22/08/22.
//

import UIKit

class ShutterViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var shutterSlider: UISlider!
    @IBOutlet weak var shutterValue: UILabel!
    var learning: Learning?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func shutterSlider(_ sender: UISlider) {
        hapticButton(type: 4)
        image.image = UIImage(named: "s\(Int(shutterSlider.value))")
        shutterValue.text = "\(CameraConstants.ExposureDurationValues[Int(shutterSlider.value) - 1].value)/\(CameraConstants.ExposureDurationValues[Int(shutterSlider.value) - 1].timescale)"
    }
    
    func setupView() {
        titleLabel.text = learning?.learningTitle
        descLabel.text = learning?.learningDesc
        
        
//        shutterValue.text = "\(CameraConstants.ExposureDurationValues[Int(shutterSlider.value) + 1])"
        
       
        print(shutterSlider.value)
    }
    

}
