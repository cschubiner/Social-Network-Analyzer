//
//  FbHelper.swift
//  Social Network Analyzer
//
//  Created by Douglas Safreno on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import Foundation

struct FbHelper {
    static func getAllPosts(callback: ([FbPost]) -> ()) {
        FBRequestConnection.startWithGraphPath("/me/feed") { connection, result, error in
            var data = (result as [String: AnyObject])["data"]! as [AnyObject]
            println(data)
            var posts = data.map() { FbPost($0) }
            callback(posts)
        }
    }
}