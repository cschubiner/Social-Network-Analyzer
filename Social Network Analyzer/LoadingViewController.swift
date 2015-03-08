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
    
    override func viewDidAppear(animated: Bool) {
        if (!self.instagramHasLoaded) {
            activity.startAnimating()
            
            FBSession.openActiveSessionWithReadPermissions(["public_profile, user_photos, read_stream"], allowLoginUI: true, completionHandler: { session, state, error in
                println("Logged in with Facebook!")
                println("permissions: \(FBSession.activeSession().accessTokenData.permissions)")
                dispatch_async(dispatch_get_main_queue()) {
                    FbHelper.startLoadingData()
                    self.instagramHasLoaded = true;
                    self.performSegueWithIdentifier("loadingToInstagramController", sender: nil)
                }
            })
            return;
        }
        
        if (InstagramEngine.sharedEngine().accessToken != nil) {
            println("Logged in with Instagram!")
            self.performSegueWithIdentifier("loadingToTabBarController", sender: nil)
        }
        else {
            self.performSegueWithIdentifier("loadingToInstagramController", sender: nil)
        }
    }

}
