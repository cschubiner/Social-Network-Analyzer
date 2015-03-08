//
//  FbPost.swift
//  Social Network Analyzer
//
//  Created by Douglas Safreno on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import Foundation


class FbPost {
    private let data: [String: AnyObject]
    init(_ data: AnyObject) {
        self.data = data as [String: AnyObject]
        print(data)
    }
    
    var creationTime: NSDate {
        let df = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return df.dateFromString(data["created_time"] as String)!
    }
    
    var text: String? {
       return data["message"] as? String
    }
    
    var likers: [Int] {
        var likers = [Int]()
        if let likes = data["likes"] as? [String: AnyObject] {
            if let likesData = likes["data"] as? [[String: AnyObject]] {
                for like in likesData {
                    let id = like["id"] as String
                    likers.append(NSString(string: id).integerValue)
                }
            }
        }
        return likers
    }
    
    var numLikes: Int {
        return countElements(likers)
    }
    
    var pictureURL: NSURL? {
        if let url = data["picture"] as? String {
            return NSURL(string: url)
        }
        return nil
    }
    
    var caption: String? {
        return data["description"] as? String
    }
}