//
//  GraphsViewController.swift
//  Social Network Analyzer
//
//  Created by Douglas Safreno on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

private let oneWeek = 7.0 * 24 * 60 * 60
private let times = [oneWeek, oneWeek * 5, oneWeek * 52, oneWeek * 1000]
private let initVal = 0.0000001

class GraphsViewController: UITableViewController {
    //@IBOutlet weak var postsByHourView: HoursHistogramView!
    //@IBOutlet weak var avgLikesView: HoursHistogramView!
    
    @IBOutlet weak var avgLikesView: HoursHistogramView!
    @IBOutlet weak var postsByHourView: HoursHistogramView!
    var fbHook: Int?
    var startTime: NSDate = NSDate(timeIntervalSinceNow: -1 * times.last!) {
        didSet {
            postsByHour = [Double](count: 24, repeatedValue: initVal)
            avgLikesPerHour = [Double](count: 24, repeatedValue: initVal)
            updateData(FbHelper.allPosts)
        }
    }
    
    private var postsByHour = [Double](count: 24, repeatedValue: initVal)
    private var avgLikesPerHour = [Double](count: 24, repeatedValue: initVal)
    
    private func updateData(posts: [FbPost]) {
        for post in posts {
            if post.creationTime.compare(startTime) == NSComparisonResult.OrderedDescending {
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: post.creationTime)
                let hour = components.hour
                let totalLikes = avgLikesPerHour[hour] * postsByHour[hour] + Double(post.numLikes)
                postsByHour[hour] += 1
                avgLikesPerHour[hour] = totalLikes / postsByHour[hour]
            }
        }
        postsByHourView?.data = postsByHour
        avgLikesView?.data = avgLikesPerHour
    }
    
    @IBOutlet weak var timeControl: UISegmentedControl!
    @IBAction func timeChanged() {
        startTime = NSDate(timeIntervalSinceNow: -1 * times[timeControl.selectedSegmentIndex])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fbHook = FbHelper.registerCallback(updateData)
    }
    
    deinit {
        if let hook = fbHook {
            FbHelper.deregisterCallback(hook)
        }
    }

    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
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
