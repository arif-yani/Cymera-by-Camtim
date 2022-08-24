//
//  LearningViewController.swift
//  Camera Simulator
//
//  Created by Rasyid Ridla on 11/05/22.
//

import UIKit

class LearningViewController: UITableViewController {
    
    @IBOutlet var learningTableView: UITableView!
    
    var listLearning: [Learning] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
    }
}

extension LearningViewController {
    
    func setupTable() {
        let nib = UINib(nibName: learningCellId, bundle: nil)
        learningTableView.register(nib, forCellReuseIdentifier: learningCellId)
        
        listLearning.append(contentsOf: Learning.dataLearning())
    }
}

extension LearningViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listLearning.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let learningListData = listLearning[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: learningCellId) as! LearningTableViewCell
        
        cell.selectionStyle = .none
        cell.learning = learningListData
//        cell.learningImg.image = UIImage(named: listLearning[indexPath.row].learningImg)
        cell.updateCell()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let destinationVC = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: detailVCId) as! DetailViewController
            destinationVC.learning = listLearning[indexPath.row]
            
            navigationController?.pushViewController(destinationVC, animated: true)
        } else if indexPath.row == 1 {
            let destinationVCShutter = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: shutterVCId) as! ShutterViewController
            destinationVCShutter.learning = listLearning[indexPath.row]
            navigationController?.pushViewController(destinationVCShutter, animated: true)
        } else if indexPath.row == 2 {
            let destinationVCFocus = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: focusVCId) as! FocusViewController
            destinationVCFocus.learning = listLearning[indexPath.row]
            
            navigationController?.pushViewController(destinationVCFocus, animated: true)
        } else if indexPath.row == 3 {
            let destinationVCGrid = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: gridVCId) as! GridViewController
            destinationVCGrid.learning = listLearning[indexPath.row]
            
            navigationController?.pushViewController(destinationVCGrid, animated: true)
        }        
        
    }
    
}
