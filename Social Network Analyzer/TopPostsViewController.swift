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
    
    var topFBPosts = [TopFBPost]()
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        findAllData()
    }
    
    private func findAllData() {
        let fakePost = TopFBPost(postText: "Hello There", datePosted: "December 7, 2012", numLikes: 20000)
        topFBPosts.append(fakePost)
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