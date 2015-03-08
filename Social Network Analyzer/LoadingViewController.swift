//
//  LoadingViewController.swift
//  Social Network Analyzer
//
//  Created by Douglas Safreno on 3/7/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var activity: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activity.startAnimating()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginInstagramButton(sender: UIButton) {
        dispatch_async(dispatch_get_main_queue()) {
            sender.enabled = false;
            self.performSegueWithIdentifier("loadingToInstagramController", sender: nil)
        }
    }
    
    @IBAction func loginFacebookButton(sender: UIButton) {
        FBSession.openActiveSessionWithReadPermissions(["public_profile, user_photos, read_stream"], allowLoginUI: true, completionHandler: { session, state, error in
            sender.enabled = false;
            println("permissions: \(FBSession.activeSession().accessTokenData.permissions)")
        })
        

    }
    
    @IBAction func skipLoginButton(sender: UIButton) {
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("loadingToTabBarController", sender: nil)
        }
    }
}
