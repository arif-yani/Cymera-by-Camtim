//
//  FocusViewController.swift
//  Camera Simulator
//
//  Created by Muhamad Arif on 22/08/22.
//

import UIKit

class FocusViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet weak var focusImage: UIImageView!
    @IBOutlet weak var focusValue: UILabel!
    @IBOutlet weak var focusSlider: UISlider!
    @IBOutlet weak var focusStatus: UILabel!
    
    var learning: Learning?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    @IBAction func focusSlider(_ sender: UISlider) {
        
        if focusSlider.value <= 0.4 {
            focusImage.image = UIImage(named: "front")
            focusStatus.text = "Front"
        } else if focusSlider.value <= 0.7 {
            focusImage.image = UIImage(named: "mid")
            focusStatus.text = "Middle"
        } else {
            focusImage.image = UIImage(named: "back")
            focusStatus.text = "Back"
        }
        
    }
    
    func setupView() {
        titleLabel.text = learning?.learningTitle
        descLabel.text = learning?.learningDesc
        focusImage.image = UIImage(named: "front")
        focusStatus.text = "Front"
    }
    

}
