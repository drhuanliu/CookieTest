//
//  ViewController.swift
//  BrowserTest
//
//  Created by Huan Liu on 9/30/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func showClicked(_ sender: Any) {
        show()
    }
    func show () {
        let urlString = "https://drhuanliu.github.io/index.html"

        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self

            present(vc, animated: true)
        }
    }


}

