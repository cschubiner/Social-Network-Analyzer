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
    @IBOutlet weak var fbPhotoView: UIImageView!
    
    
    var post : FbPost? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        // reset existing post data
        postTextLabel?.text = nil
        dateTextLabel?.text = nil
        likeNumLabel?.text = nil
        fbPhotoView?.image = nil
        
        if let post = post {
            if post.text != nil {
                postTextLabel.text = post.text
            } else if post.caption != nil {
                println(post.caption)
                postTextLabel.text = post.caption
            }
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .FullStyle
            dateFormatter.timeStyle = .ShortStyle
            dateTextLabel.text = dateFormatter.stringFromDate(post.creationTime)
            likeNumLabel.text = "\(post.numLikes)"
            
            if let url = post.pictureURL {
                fetchImage(url)
            }
        }
    }
    
    // fetches the image at imageURL
    // does so off the main thread
    // then puts a closure back on the main queue
    //   to handle putting the image in the UI
    //   (since we aren't allowed to do UI anywhere but main queue)
    private func fetchImage(imageURL: NSURL)
    {
        let url = imageURL
        let qos = Int(QOS_CLASS_USER_INITIATED.value)
        dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
            let imageData = NSData(contentsOfURL: url) // this blocks the thread it is on
            dispatch_async(dispatch_get_main_queue()) {
                if imageData != nil {
                    // this might be a waste of time if our MVC is out of action now
                    // which it might be if someone hit the Back button
                    // or otherwise removed us from split view or navigation controller
                    // while we were off fetching the image
                    self.fbPhotoView?.image = UIImage(data: imageData!)
                } else {
                    self.fbPhotoView?.image = nil
                }
            }
        }
    }
    
    
}
