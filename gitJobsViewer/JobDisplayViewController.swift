//
//  JobDisplayViewController.swift
//  gitJobsViewer
//
//  Created by NathanWSjoquist on 7/7/15.
//  Copyright (c) 2015 Nathan Sjoquist. All rights reserved.
//

import UIKit

protocol JobDisplayExitDelegate{
    func exitJobView(jobVC:JobDisplayViewController)
}
class JobDisplayViewController: UIViewController {

    @IBOutlet weak var jobDisplayField: UITextView!
    var owner:JobDisplayExitDelegate?
    var applyHereLink:NSURL?
    @IBOutlet weak var checkoutButton: UIButton!
   
    @IBAction func checkoutAction(sender: AnyObject) {
        NSLog("apply here:\(self.applyHereLink)")

        if self.applyHereLink != nil{
            UIApplication.sharedApplication().openURL(self.applyHereLink!)
        }
    }
    @IBAction func exitAction(sender: AnyObject) {
        owner?.exitJobView(self)
    }
}
