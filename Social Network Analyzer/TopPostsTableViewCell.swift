//
//  TopPostsTableViewCell.swift
//  Social Network Analyzer
//
//  Created by Raissa Largman on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

class TopPostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var likeNumLabel: UILabel!
    @IBOutlet weak var photoView: UIView!
    
    
    var post : FbPost? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        println("hello")
        if let post = post {
            postTextLabel.text = post.text
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .FullStyle
            dateFormatter.timeStyle = .ShortStyle
            dateTextLabel.text = dateFormatter.stringFromDate(post.creationTime)
            
            likeNumLabel.text = "\(post.numLikes)"
            //dateTextLabel.text = post.datePosted
            //likeNumLabel.text = "\(post.numLikes)"
        }
    }
    
    
}
