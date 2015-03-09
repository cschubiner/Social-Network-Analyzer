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
    
    var instagramHasLoaded = false;

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var loginLabel: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        if (!self.instagramHasLoaded) {
            
            FBSession.openActiveSessionWithReadPermissions(["public_profile, user_photos, read_stream"], allowLoginUI: true, completionHandler: { session, state, error in
                println("Logged in with Facebook!")
                println("permissions: \(FBSession.activeSession().accessTokenData.permissions)")
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.loginLabel.text = "Logging in to Instagram..."
                    
                    FbHelper.startLoadingData()
                    self.instagramHasLoaded = true;
                    self.performSegueWithIdentifier("loadingToInstagramController", sender: nil)
                }
            })
            return;
        }
        
        if (InstagramEngine.sharedEngine().accessToken != nil) {
            self.loginLabel.text = "Logging in..."
            println("Logged in with Instagram!")
            self.performSegueWithIdentifier("loadingToTabBarController", sender: nil)
        }
        else {
            self.performSegueWithIdentifier("loadingToInstagramController", sender: nil)
        }
    }

}
