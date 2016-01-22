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
    
    

    override func viewDidLoad()
    {
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
                let url = NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
                let request = NSMutableURLRequest(URL: url!)
                PFTwitterUtils.twitter()?.signRequest(request)
                
                NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
                    do {
                    let responseDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves)
                    let imageUrl = responseDict["profile_image_url_https"] as! String
                    let name = responseDict["name"] as! String
//                        print(imageUrl)
//                        print(name)
                        user!.setObject(imageUrl, forKey: "image")
                        user!.setObject(name, forKey: "name")
                        
                        user?.saveInBackground()
                        
                    } catch {}
                }).resume()
                
                self.performSegueWithIdentifier("segueSuccess", sender: nil)
            }
        }
    }

}

