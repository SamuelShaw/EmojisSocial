//
//  ViewController.swift
//  EmojisSocial
//
//  Created by Samuel Shaw on 1/7/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit
import Parse
import ParseTwitterUtils

class ViewController: UIViewController
{
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func twitterButtonPressed(sender: UIButton)
    {
        PFTwitterUtils.initializeWithConsumerKey("pUp0j6mcIQBaBplAspoCo6pbA", consumerSecret: "ec3ZL6QL23wtME80SlU8TlHURNBl10aRQNgJv4zyTDsgNT4yno")
        
        PFTwitterUtils.logInWithBlock { (user: PFUser?, error: NSError?) -> Void in
            if user == nil
            {
                print("We got a problem")
            }
            else
            {
                self.performSegueWithIdentifier("segueSuccess", sender: nil)
            }
        }
    }

}

