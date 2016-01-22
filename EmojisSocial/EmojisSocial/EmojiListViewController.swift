//
//  EmojiListViewController.swift
//  EmojisSocial
//
//  Created by Samuel Shaw on 1/7/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit
import Parse

class EmojiListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var tableView: UITableView!
    
    var emojiPosts = [PFObject]()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        updateEmojiPosts()
    }
    
    func updateEmojiPosts()
    {
        let query = PFQuery(className: "EmojiPost")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (emojiPosts:[PFObject]?, error:NSError?) -> Void in
            print(emojiPosts)
            if error == nil
            {
                self.emojiPosts = emojiPosts!
                self.tableView.reloadData()
            }
        }
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiPosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("emojiCell") as! EmojiPostTableViewCell
        let emojiPost = self.emojiPosts[indexPath.row]
        let user = emojiPost["user"] as! PFUser
        do {
            try user.fetchIfNeeded()
        } catch {
            print("There was an error")
        }
        cell.emojiLabel!.text = emojiPost["emoji"] as? String
        cell.messageLabel!.text = emojiPost["message"] as? String
        cell.usernameLabel!.text = user["name"] as? String
        
        let url = user["image"] as! String
        let imageData = NSData(contentsOfURL: NSURL(string: url)!)
        
        if imageData == nil {
            cell.userImageView.image = UIImage()
        } else {
            cell.userImageView.image = UIImage(data: imageData!)
        }
        return cell
    }

}
