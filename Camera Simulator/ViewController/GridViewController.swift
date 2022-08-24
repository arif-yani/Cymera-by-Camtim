//
//  GridViewController.swift
//  Camera Simulator
//
//  Created by Muhamad Arif on 22/08/22.
//

import UIKit

class GridViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imageGrid: UIImageView!
    @IBOutlet weak var gridSymetry: UIButton!
    @IBOutlet weak var gridThird: UIButton!
    @IBOutlet weak var gridDiagonal: UIButton!
    @IBOutlet weak var imagePhoto: UIImageView!
    
    var learning: Learning?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        gridThird.tintColor = .gray
        gridDiagonal.tintColor = .gray
        gridSymetry.tintColor = .white
        
       
    }
    @IBAction func symetryGrid(_ sender: UIButton) {
        gridThird.tintColor = .gray
        gridDiagonal.tintColor = .gray
        gridSymetry.tintColor = .white
        
        imagePhoto.image = UIImage(named: "symetry")
        imageGrid.image = UIImage(named: "symetriGrid")
    }
    
    @IBAction func thirdGrid(_ sender: UIButton) {
        gridThird.tintColor = .white
        gridDiagonal.tintColor = .gray
        gridSymetry.tintColor = .gray
        
        imagePhoto.image = UIImage(named: "third")
        imageGrid.image = UIImage(named: "thirdgrid")
    }
    
    @IBAction func diagonalGrid(_ sender: UIButton){
        gridThird.tintColor = .gray
        gridDiagonal.tintColor = .white
        gridSymetry.tintColor = .gray
        
        imagePhoto.image = UIImage(named: "diagonal")
        imageGrid.image = UIImage(named: "gridDiagonal")
    }
    
    func setupView() {
        titleLabel.text = learning?.learningTitle
        descLabel.text = learning?.learningDesc
        
        imagePhoto.image = UIImage(named: "symetry")
        imageGrid.image = UIImage(named: "symetriGrid")
    }

}
