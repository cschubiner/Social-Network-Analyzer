//
//  PeopleTableViewController.swift
//  Social Network Analyzer
//
//  Created by Clayton Schubiner on 3/8/15.
//  Copyright (c) 2015 Douglas Safreno. All rights reserved.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    struct PostLiker {
        var userName = ""
        var numLikes = 0
    }
    
    var instagramLikers: [PostLiker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0), { ()->() in
            InstagramHelper.getAllPosts() { posts in
                
                var instagramLikersDict = [String : PostLiker]()
                
                for post: InstagramMedia in posts {
                    for user in post.likes {
                        
                        let user = user as InstagramUser
                        let userName = user.username
                        if (instagramLikersDict[userName] == nil) {
                            var pl = PostLiker()
                            pl.userName = userName
                            pl.numLikes = 0
                            instagramLikersDict[userName] = pl
                        }
                        instagramLikersDict[userName]?.numLikes += 1
                    }
                }
                
                self.instagramLikers = [PostLiker](instagramLikersDict.values)
                self.instagramLikers.sort({$0.numLikes > $1.numLikes})
                

                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
            
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (section == 0) {
            return 0;
        }
        return instagramLikers.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("peopleCell", forIndexPath: indexPath) as UITableViewCell
        
        if (indexPath.section == 1) {
            //instagram
            
               let liker = self.instagramLikers[indexPath.row] as PostLiker
               cell.textLabel?.text = liker.userName + " - " + String(liker.numLikes) + " likes"
            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
