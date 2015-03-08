//
//  GraphsViewController.swift
//  Social Network Analyzer
//
//  Created by Douglas Safreno on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

class GraphsViewController: UIViewController {
    @IBOutlet weak var postsByHourView: HoursHistogramView!
    @IBOutlet weak var avgLikesView: HoursHistogramView!
    
    var fbHook: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var postsByHour = [Double](count: 24, repeatedValue: 0)
        var avgLikesPerHour = [Double](count: 24, repeatedValue: 0)
        fbHook = FbHelper.registerCallback() { posts in
            for post in posts {
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: post.creationTime)
                let hour = components.hour
                let totalLikes = avgLikesPerHour[hour] * postsByHour[hour] + Double(post.numLikes)
                postsByHour[hour] += 1
                avgLikesPerHour[hour] = totalLikes / postsByHour[hour]
            }
            self.postsByHourView?.data = postsByHour
            self.avgLikesView?.data = avgLikesPerHour
        }

        // Do any additional setup after loading the view.
    }
    
    deinit {
        if let hook = fbHook {
            FbHelper.deregisterCallback(hook)
        }
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
