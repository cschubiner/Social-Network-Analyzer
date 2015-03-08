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
    
    
    var post : TopFBPost? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let post = post {
            postTextLabel.text = post.postText
            dateTextLabel.text = post.datePosted            
            likeNumLabel.text = "\(post.numLikes)"
        }
    }
    
    
}
