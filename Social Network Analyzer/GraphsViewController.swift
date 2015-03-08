//
//  GraphsViewController.swift
//  Social Network Analyzer
//
//  Created by Douglas Safreno on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

class GraphsViewController: UIViewController {
    @IBOutlet weak var bestTime: HoursHistogramView!
    @IBOutlet weak var timeAfter: HoursHistogramView!

    override func viewDidLoad() {
        super.viewDidLoad()
        FbHelper.getAllPosts() { posts in
            for post in posts {
                println("\(post.numLikes): \(post.text)")
            }
        }

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
