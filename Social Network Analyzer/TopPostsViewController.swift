//
//  TopPostsViewController.swift
//  Social Network Analyzer
//
//  Created by Raissa Largman on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

class TopPostsViewController: UITableViewController {

    // MARK: - Public API
    
    var topFBPosts = [FbPost]()
    var topIGPosts = [InstagramMedia]()
    let NUM_TOP_POSTS = 10
    @IBOutlet weak var socialNetworkControl: UISegmentedControl!
    
    var socialNetwork: String = "IG" {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        findAllData()
    }
    
    var fbHook: Int?
    
    private func findAllData() {
        fbHook = FbHelper.registerCallback(findAllFBData)
        InstagramHelper.getAllPosts(findAllIGData)
    }
    
    deinit {
        if let fbHook = fbHook {
            FbHelper.deregisterCallback(fbHook)
        }
    }
    
    private func findAllIGData(allPosts: [InstagramMedia]) {
        topIGPosts = [InstagramMedia]()
        var sortedPosts = allPosts
        sortedPosts.sort { $1.likesCount < $0.likesCount }
        if sortedPosts.count < NUM_TOP_POSTS {
            topIGPosts = sortedPosts
        } else {
            topIGPosts = Array(sortedPosts[0...NUM_TOP_POSTS])
        }
        self.tableView.reloadData()
    }
    
    private func findAllFBData(allPosts: [FbPost]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { ()->() in

            var sortedPosts = self.topFBPosts + allPosts
            sortedPosts.sort { $1.numLikes < $0.numLikes }
            if sortedPosts.count <= self.NUM_TOP_POSTS {
                self.topFBPosts = sortedPosts
            } else {
                self.topFBPosts = Array(sortedPosts[0...self.NUM_TOP_POSTS])
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        })
    }
    
    private struct Storyboard {
        static let FBCellReuseIdentifier = "fbPost"
    }
    
    // MARK: - Toggle data source
    
    @IBAction func toggledSocialNetwork(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            socialNetwork = "IG"
        case 1:
            socialNetwork = "FB"
        default:
            break
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if socialNetwork == "IG" {
            return topIGPosts.count
        } else if socialNetwork == "FB" {
            return topFBPosts.count
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.FBCellReuseIdentifier, forIndexPath: indexPath) as TopPostsTableViewCell
        
        if socialNetwork == "FB" {
            cell.post = topFBPosts[indexPath.row]
        } else if socialNetwork == "IG" {
            cell.post = topIGPosts[indexPath.row]
        }
        
        return cell
    }
    
}