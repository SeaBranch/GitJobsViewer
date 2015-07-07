//
//  SearchResultsViewController.swift
//  gitJobsViewer
//
//  Created by NathanWSjoquist on 7/6/15.
//  Copyright (c) 2015 Nathan Sjoquist. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,JobSearchRecieverDelegate {
    
    @IBOutlet var tableView:UITableView?
    
    @IBOutlet weak var newSearchBBI: UIBarButtonItem!
    
    var searchSession:JobSearchSession?
    var viewModel:SearchResultsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SearchResultsViewModel()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        return UIView()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var jobCell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("JobCell") as! UITableViewCell
        jobCell.textLabel?.text = "Title, Company"
        jobCell.detailTextLabel?.text = "Location"
        return jobCell
    }
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//    }

    func didRecieveResults(){
        var currentPageCount:Int = self.viewModel!.sectionsRequiredInTableView()
        var newPageCount:Int = self.searchSession!.jobPostings.count
        
        if currentPageCount != newPageCount{
        
            for (var idx = currentPageCount; idx < newPageCount;idx++){
                self.viewModel!.appendData(self.searchSession!.jobPostings[idx])
            }
            NSLog("newResults")
        }
    }
    func didFinishSearch(){
        NSLog("search complete")
    }


}
