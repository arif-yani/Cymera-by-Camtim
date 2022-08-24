//
//  DetailViewController.swift
//  Camera Simulator
//
//  Created by Rasyid Ridla on 15/05/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var learningImage: UIImageView!
    var learning: Learning?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dayIso: UIButton!
    @IBOutlet weak var nightIso: UIButton!
    
    @IBOutlet weak var isoStatus: UILabel!
    @IBOutlet weak var isoValue: UILabel!
    @IBOutlet weak var isoSlider: UISlider!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var keterangan: UILabel!
    
    var condition = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewDay()
        
        label.text = learning?.learningTitle
        dayIso.tintColor = .white
        nightIso.tintColor = .gray
        
        isoStatus.isHidden = true
        
    }
    
    @IBAction func dayIso(_ sender: UIButton) {
        keterangan.text = learning?.learningDesc
        setupViewDay()
        dayIso.tintColor = .white
        nightIso.tintColor = .gray
        condition = true
    }
    
    @IBAction func isoSlider(_ sender: UISlider) {
        if condition {
            setupViewDay()
        } else if !condition {
            setupViewNight()
        }
        
    }
    
    @IBAction func nightIso(_ sender: UIButton) {
        keterangan.text = learning?.learningAnim
        setupViewNight()
        dayIso.tintColor = .gray
        nightIso.tintColor = .white
        condition = false
        
        
    }
    
    func setupViewDay() {
        hapticButton(type: 6)
        keterangan.text = learning?.learningDesc
        image.image = UIImage(named: "day\(isoSlider.value)")
        isoValue.text = "\(CameraConstants.IsoValues[Int(isoSlider.value - 1)])"
        
       
        print(isoSlider.value)
    }
    
    func setupViewNight() {
        hapticButton(type: 6)
        image.image = UIImage(named: "night\(isoSlider.value)")
        isoValue.text = "\(CameraConstants.IsoValues[Int(isoSlider.value - 1)])"
        
        
        print(isoSlider.value)
    }
    
    override func viewWillLayoutSubviews() {
           keterangan.sizeToFit()
       }
        
    
    
   
    
    
}

