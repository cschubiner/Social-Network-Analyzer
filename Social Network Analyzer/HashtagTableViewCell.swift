//
//  HashtagTableViewCell.swift
//  Social Network Analyzer
//
//  Created by Raissa Largman on 3/12/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

class HashtagTableViewCell: UITableViewCell {
    
    var data : LikedHashtag? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        // reset existing data
        
        
        if let data = self.data {
        }
    }
    
}

