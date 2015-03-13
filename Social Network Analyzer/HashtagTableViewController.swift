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
    var sortedHashtags = [String]()
    
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
        for post in allPosts {
            for hashtag in post.tags {
                if let hashtagString = hashtag as? String {
                    if let statsHashtag = self.hashtags[hashtagString] {
                        statsHashtag.totalPosts += 1
                        statsHashtag.numTotalLikes += post.likesCount
                        hashtags[hashtagString] = statsHashtag
                    } else {
                        hashtags[hashtagString] = LikedHashtag(hashtag: hashtagString, likes: post.likesCount)
                    }
                }
            }
        }
        sortedHashtags = Array(hashtags.keys)
        sortedHashtags.sort {
            var stats1 = self.hashtags[$0]
            var stats2 = self.hashtags[$1]
            return stats1!.avgLikes > stats2!.avgLikes
        }
    
        self.tableView.reloadData()
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
        
        cell.data = hashtags[sortedHashtags[indexPath.row]]
        
        return cell
    }
}
