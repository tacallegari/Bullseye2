//
//  AboutViewController.swift
//  Bullseye2
//
//  Created by Tahlia Callegari on 9/4/20.
//  Copyright © 2020 Tahlia Callegari. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "Bullseye",
                                     withExtension: "html"){
        let request = URLRequest(url: url)
        webView.load(request)
        }
    }
        @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
}
