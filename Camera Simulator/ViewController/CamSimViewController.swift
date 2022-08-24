//
//  CamSimViewController.swift
//  Camera Simulator
//
//  Created by Muhamad Arif on 22/08/22.
//

import UIKit
import WebKit

class CamSimViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
   
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://bethecamera.com/")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    
    
    

    

}
