//
//  HashtagTableViewCell.swift
//  Social Network Analyzer
//
//  Created by Raissa Largman on 3/12/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

class HashtagTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    
    var data : LikedHashtag? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        // reset existing data
        hashtagLabel.text = nil
        numLikesLabel.text = nil
        
        if let data = self.data {
            hashtagLabel.text = "#" + data.hashtag
            numLikesLabel.text = String(data.avgLikes)
        }
    }
    
}

