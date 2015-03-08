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
    private static var callbacks = Dictionary<Int, (([FbPost]) -> ())>()
    private static var nextCallbackId = 0
    
    static func startLoadingData() {
        FBRequestConnection.startWithGraphPath("/me/feed", completionHandler: dataLoaded)
    }
    
    static func registerCallback(callback: ([FbPost]) -> ()) -> Int {
        let id = nextCallbackId
        nextCallbackId += 1
        callbacks[id] = callback
        if allPosts.count > 0 {
            callback(allPosts)
        }
        return id
    }
    
    static func deregisterCallback(id: Int) {
        callbacks.removeValueForKey(id)
    }
    
    private static func dataLoaded(connection: FBRequestConnection!, result: AnyObject!, error: NSError!) {
        var data = (result as [String: AnyObject])["data"]! as [AnyObject]
        var posts = data.map() { FbPost($0) }
        self.allPosts += posts
        for (id, callback) in callbacks {
            callback(posts)
        }
        if let paging = result["paging"] as? [String: AnyObject] {
            if let next = paging["next"] as? String {
                let url = NSURL(string: next)!
                let request = NSMutableURLRequest(URL: url)
                connection.urlRequest = request
                connection.start()
            }
        }
    }
}