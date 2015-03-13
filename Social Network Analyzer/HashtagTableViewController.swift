//
//  HashtagTableViewController.swift
//  Social Network Analyzer
//
//  Created by Raissa Largman on 3/12/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

class LikedHashtag {
    var hashtag: String
    var totalPosts: Int
    var numTotalLikes: Int
    var avgLikes: Int {
        return numTotalLikes / totalPosts
    }
    
    init (hashtag: String, likes: Int) {
        self.hashtag = hashtag
        self.totalPosts = 1
        self.numTotalLikes = likes
    }
}

class HashtagTableViewController: UITableViewController {
    
    var hashtags = [String:LikedHashtag]()
    
    private struct Storyboard {
        static let CellReuseIdentifier = "hashtag"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        InstagramHelper.getAllPosts(findData)
    }

    
    private func findData(allPosts: [InstagramMedia]) {
        /*for post in allPosts {
            for hashtag in post.tags {
                if let statsHashtag = hashtags[hashtag] {
                    statsHashtag.totalPosts += 1
                    hashtags[hashtag]
                } else {
                    
                }
            }
        }*/
        /*topIGPosts = [InstagramMedia]()
        var sortedPosts = allPosts
        sortedPosts.sort { $1.likesCount < $0.likesCount }
        if sortedPosts.count < NUM_TOP_POSTS {
            topIGPosts = sortedPosts
        } else {
            topIGPosts = Array(sortedPosts[0...NUM_TOP_POSTS])
        }
        self.tableView.reloadData()*/
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hashtags.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as HashtagTableViewCell
        
        cell.data = LikedHashtag(hashtag: "hello", likes: 10)
        
        return cell
    }
}