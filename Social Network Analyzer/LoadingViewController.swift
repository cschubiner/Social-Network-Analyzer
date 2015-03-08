//
//  LoadingViewController.swift
//  DatFitnessApp
//
//  Created by Douglas Safreno on 3/3/15.
//  Copyright (c) 2015 Raissa Largman. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.startAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FBSession.openActiveSessionWithReadPermissions(["public_profile"], allowLoginUI: true, completionHandler: { session, state, error in
//            if error != nil {
//                println(error)
//                self.performSegueWithIdentifier("failure", sender: nil)
//            } else if state == .Open {
//                let accessToken = session.accessTokenData.accessToken
//                FirebaseHelper.ref.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
//                    if error != nil {
//                        println(error)
//                        FBSession.activeSession().closeAndClearTokenInformation()
//                        self.performSegueWithIdentifier("failure", sender: nil)
//                    } else {
//                        FirebaseHelper.userRef().observeSingleEventOfType(.Value, withBlock: { snapshot in
//                            println(snapshot.value)
//                            if snapshot.value as? NSObject == NSNull() {
//                                self.performSegueWithIdentifier("new", sender: nil)
//                            } else {
//                                self.performSegueWithIdentifier("success", sender: nil)
//                            }
//                        }, withCancelBlock: { error in
//                            println(error)
//                        })
//                    }
//                })
//            }
        })
//        FirebaseHelper.ref.auth

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
