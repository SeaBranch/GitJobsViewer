//
//  SearchViewController.swift
//  gitJobsViewer
//
//  Created by NathanWSjoquist on 7/1/15.
//  Copyright (c) 2015 Nathan Sjoquist. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var termsField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    var requestManager:GitRequestManager?
    
    var currentSession:JobSearchSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestManager = GitRequestManager()
        self.termsField.delegate = self
        self.locationField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func searchAction(sender: AnyObject) {
        if let searchSession:JobSearchSession = self.requestManager!.newSearchSessionWithTerms(self.termsField.text, location: self.locationField.text){
            self.currentSession = searchSession
            self.beginSearch()
        }
    }
    func beginSearch(){
        self.performSegueWithIdentifier("ShowSearchResults", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var resultsVC = segue.destinationViewController as! SearchResultsViewController
        resultsVC.searchSession = self.currentSession!
        self.currentSession!.reciever = resultsVC
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    

}
