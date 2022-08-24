//
//  InfoViewController.swift
//  Camera Simulator
//
//  Created by Muhamad Arif on 23/08/22.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    var info: [Info] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        info.append(contentsOf: Info.dataInfo())
        self.tableView.layer.cornerRadius = 10.0
        setUpCell()
        
    }
    
    func setUpCell () {
        let nib = UINib(nibName: "InfoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InfoCell
        
        cell.title.text = info[indexPath.row].title
        cell.subtitle.text = info[indexPath.row].subtitle
        cell.img.image = UIImage(named: info[indexPath.row].image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrivacyViewController") as! PivacyViewController
            
            navigationController?.pushViewController(destinationVC, animated: true)
            
        } else if indexPath.row == 3 {
            let destinationVCAbout = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            navigationController?.pushViewController(destinationVCAbout , animated: true)
        } else if indexPath.row == 0 {
            let text = "https://bit.ly/Cymera"
            
            // set up activity view controller
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        } else if indexPath.row == 1 {
            if let url = URL(string: "itms-apps://apple.com/app"),
                    UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url, options: [:]) { (opened) in
                        if(opened){
                            print("App Store Opened")
                        }
                    }
                } else {
                    print("Can't Open URL on Simulator")
                }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
   

}
