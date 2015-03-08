//
//  TopPostsViewController.swift
//  Social Network Analyzer
//
//  Created by Raissa Largman on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

class TopFBPost {
    var postText: String
    var datePosted: String
    var numLikes: Int
    
    init(postText: String, datePosted: String, numLikes: Int) {
        self.postText = postText
        self.datePosted = datePosted
        self.numLikes = numLikes
    }
}

class TopPostsViewController: UITableViewController {

    // MARK: - Public API
    
    var topFBPosts = [FbPost]()
    let NUM_TOP_POSTS = 10
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        FbHelper.getAllPosts(findAllData)
    }
    
    private func findAllData(allPosts: [FbPost]) {
        let sortedPosts = allPosts.sorted { $1.numLikes < $0.numLikes }
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
        
        cell.post = topFBPosts[indexPath.row]
        
        return cell
    }
}