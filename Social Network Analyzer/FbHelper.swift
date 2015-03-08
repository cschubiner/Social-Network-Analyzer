//
//  FbHelper.swift
//  Social Network Analyzer
//
//  Created by Douglas Safreno on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import Foundation

struct FbHelper {
    static var allPosts = [FbPost]()
    static var isLoadingPosts = false
    static func getAllPosts(callback: ([FbPost]) -> ()) {
        FBRequestConnection.startWithGraphPath("/me/feed") { connection, result, error in
            var data = (result as [String: AnyObject])["data"]! as [AnyObject]
            var posts = data.map() { FbPost($0) }
            callback(posts)
        }
    }
    
    static func keepGettingAllPosts(callback: ([FbPost]) -> ()) {
        allPosts = [FbPost]()
        isLoadingPosts = true
        FBRequestConnection.startWithGraphPath("/me/feed") { connection, result, error in
            var data = (result as [String: AnyObject])["data"]! as [AnyObject]
            var posts = data.map() { FbPost($0) }
            self.allPosts += posts
            if let paging = result["paging"] as? [String: AnyObject] {
                if let next = paging["next"] as? String {
                    println(next)
                    let url = NSURL(string: next)!
                    let request = NSMutableURLRequest(URL: url)
                    connection.urlRequest = request
                    connection.start()
                } else {
                    self.isLoadingPosts = false
                }
            } else {
                self.isLoadingPosts = false
            }
            callback(posts)
        }
    }
}