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
    
    var socialNetwork: String = "FB" {
        didSet {
            findAllData()
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
        if socialNetwork == "FB" {
            fbHook = FbHelper.registerCallback(findAllFBData)
        } else if socialNetwork == "IG" {
            InstagramHelper.getAllPosts(findAllIGData)
        }
    }
    
    deinit {
        if let fbHook = fbHook {
            FbHelper.deregisterCallback(fbHook)
        }
    }
    
    private func findAllIGData(allPosts: [InstagramMedia]) {
        topIGPosts = [InstagramMedia]()
        let sortedPosts = allPosts.sorted { $1.likesCount < $0.likesCount }
        if sortedPosts.count < NUM_TOP_POSTS {
            topIGPosts = sortedPosts
        } else {
            topIGPosts = Array(sortedPosts[0...NUM_TOP_POSTS])
        }
        self.tableView.reloadData()
    }
    
    private func findAllFBData(allPosts: [FbPost]) {
        topFBPosts = [FbPost]()
        let sortedPosts = FbHelper.allPosts.sorted { $1.numLikes < $0.numLikes }
        if sortedPosts.count < NUM_TOP_POSTS {
            topFBPosts = sortedPosts
        } else {
            topFBPosts = Array(sortedPosts[0...NUM_TOP_POSTS])
        }
        self.tableView.reloadData()
    }
    
    private struct Storyboard {
        static let FBCellReuseIdentifier = "fbPost"
    }
    
    // MARK: - Toggle data source
    
    @IBAction func toggledSocialNetwork(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            socialNetwork = "FB"
        case 1:
            socialNetwork = "IG"
        default:
            break
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topFBPosts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.FBCellReuseIdentifier, forIndexPath: indexPath) as TopPostsTableViewCell
        
        if socialNetwork == "FB" {
            cell.post = topFBPosts[indexPath.row]
        } else if socialNetwork == "IG" {
            cell.IGPost = topIGPosts[indexPath.row]
        }
        
        return cell
    }
    
}