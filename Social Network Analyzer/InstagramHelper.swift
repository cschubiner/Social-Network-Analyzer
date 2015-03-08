//
//  InstagramHelper.swift
//  Social Network Analyzer
//
//  Created by Clayton Schubiner on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

struct InstagramHelper {
    static func getAllPosts(callback: ([InstagramMedia]) -> ()) {
        
        let eng = InstagramEngine.sharedEngine();

        eng.getSelfUserDetailsWithSuccess({ (user : InstagramUser!)  in
            eng.getMediaForUser(user.Id, withSuccess: { media, paginationInfo in
                let m = media as [InstagramMedia]!
                callback(m);
                }, failure: { (error: NSError!) in
                    println(error)
            })
            }, failure: { error in
                println("instagram failed");
        })
    }
}