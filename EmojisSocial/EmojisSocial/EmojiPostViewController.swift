//
//  EmojiPostViewController.swift
//  EmojisSocial
//
//  Created by Samuel Shaw on 1/7/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit
import Parse

class EmojiPostViewController: UIViewController
{
    
    @IBOutlet weak var emojiTextfield: UITextField!
    
    @IBOutlet weak var messageTextfield: UITextField!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.errorLabel.text = ""
        self.emojiTextfield.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func cancelButtonPressed(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postButtonPressed(sender: AnyObject)
    {
        if self.emojiTextfield.text!.isEmpty
        {
           self.errorLabel.text = "Please enter an emoji"
        }
        else
        {
            if self.messageTextfield.text!.isEmpty
            {
                self.errorLabel.text = "Message Field is empty"
            }
            else
            {
                if self.emojiTextfield.text!.characters.count > 1
                {
                    // too many emojis
                    self.errorLabel.text = "Please enter only 1 emoji"
                }
                else
                {
                    // lets make an emoji post
                    self.errorLabel.text = ""
                    createEmojiPost()
                }
            }
        }
        
    }
    
    func createEmojiPost()
    {
        let emojiPost = PFObject(className: "EmojiPost")
        
        emojiPost.setObject(self.emojiTextfield.text!, forKey: "emoji")
        emojiPost.setObject(self.messageTextfield.text!, forKey: "message")
        emojiPost.setObject(PFUser.currentUser()!, forKey: "user")
        
        emojiPost.saveInBackgroundWithBlock { (saved:Bool, error:NSError?) -> Void in
            if saved
            {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else
            {
                self.errorLabel.text = "Upload failed please try again"
            }
        }
    }
         
}
