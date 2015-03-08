//
//  LoadingViewController.swift
//  Social Network Analyzer
//
//  Created by Douglas Safreno on 3/7/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        FBSession.openActiveSessionWithReadPermissions(["public_profile, user_photos, read_stream"], allowLoginUI: true, completionHandler: { session, state, error in
            println(session)
            println(state)
            println(error)
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
