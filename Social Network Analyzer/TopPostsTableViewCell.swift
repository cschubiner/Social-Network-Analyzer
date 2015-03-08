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
    @IBOutlet weak var photoView: UIImageView!
    
    
    var post : AnyObject? {
        didSet {
            updateUI()
        }
    }
    
    var photoDictionary = [NSURL: UIImage]()
    
    func updateUI() {
        // reset existing post data
        postTextLabel?.text = nil
        dateTextLabel?.text = nil
        likeNumLabel?.text = nil
        photoView?.image = nil
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .FullStyle
        dateFormatter.timeStyle = .ShortStyle
        
        if let post = post as? FbPost {
            if post.text != nil {
                postTextLabel.text = post.text
            } else if post.caption != nil {
                println(post.caption)
                postTextLabel.text = post.caption
            }
            dateTextLabel.text = dateFormatter.stringFromDate(post.creationTime)
            likeNumLabel.text = "\(post.numLikes)"
            
            if let url = post.pictureURL {
                if let image = photoDictionary[url] {
                    self.photoView?.image = image
                } else {
                    fetchImage(url)
                }
            }
        } else if let post = post as? InstagramMedia {
            if post.caption != nil {
                postTextLabel.text = post.caption.text
            }
            dateTextLabel.text = dateFormatter.stringFromDate(post.createdDate)
            likeNumLabel.text = "\(post.likesCount)"
            
            if let url = post.standardResolutionImageURL {
                if let image = photoDictionary[url] {
                    self.photoView?.image = image
                } else {
                    fetchImage(url)
                }
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
                    let image = UIImage(data: imageData!)
                    self.photoView?.image = image
                    self.photoDictionary[imageURL] = image
                } else {
                    self.photoView?.image = nil
                }
            }
        }
    }
    
    
}
