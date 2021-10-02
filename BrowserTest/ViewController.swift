//
//  ViewController.swift
//  BrowserTest
//
//  Created by Huan Liu on 9/30/21.
//

import UIKit
import SafariServices
import AuthenticationServices
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func showClicked(_ sender: Any) {
        show()
    }
    @IBAction func showSFAClicked(_ sender: Any) {
        showSFSession()
    }
    @IBAction func showASWClicked(_ sender: Any) {
        showASSession()
    }
    
    let urlString = "https://drhuanliu.github.io/index.html"
    let callbackScheme = "fake://"
    
    func show () {

        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self

            present(vc, animated: true)
        }
    }

    var authSession: ASWebAuthenticationSession?

    func showASSession() {
        let session = ASWebAuthenticationSession(
            url: URL(string: urlString)!,
            callbackURLScheme: callbackScheme)
        { redirectUrl, error in
            // Pull the arguments out of the
            // redirectUrl, or handle the supplied
            // error
        }
        session.presentationContextProvider = self
        session.start()
        self.authSession = session
    }
    
    
    var sfAuthSession: SFAuthenticationSession?
    func showSFSession() {
        //OAuth Provider URL
        let authURL = URL(string: urlString)
        let callbackUrlScheme = callbackScheme

        //Initialize auth session
        self.sfAuthSession = SFAuthenticationSession.init(url: authURL!, callbackURLScheme: callbackUrlScheme,
                                                        completionHandler: { (callBack:URL?, error:Error?) in

            // handle auth response
            guard error == nil, let successURL = callBack else {
                return
            }

            let oauthToken = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "code"}).first

            // Do what you now that you've got the token, or use the callBack URL
            print(oauthToken ?? "No OAuth Token")
        })

        //Kick it off
        self.sfAuthSession?.start()
    }

}

