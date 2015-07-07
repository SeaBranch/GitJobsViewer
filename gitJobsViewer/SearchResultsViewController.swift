//
//  SearchResultsViewController.swift
//  gitJobsViewer
//
//  Created by NathanWSjoquist on 7/6/15.
//  Copyright (c) 2015 Nathan Sjoquist. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,JobSearchRecieverDelegate,JobDisplayExitDelegate {
    
    @IBOutlet weak var tableView:UITableView?
    
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
        var sb = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var jobVC:JobDisplayViewController = sb.instantiateViewControllerWithIdentifier("JobDisplayViewController") as! JobDisplayViewController
        self.presentViewController(jobVC, animated: true) { () -> Void in
            jobVC.jobDisplayField.text = self.viewModel?.displayTextForIndex(indexPath)
            jobVC.applyHereLink = self.viewModel!.infoLocationForIndex(indexPath)
            jobVC.checkoutButton.enabled = jobVC.applyHereLink != nil
            jobVC.owner = self
        }
    }
    func exitJobView(jobVC:JobDisplayViewController) {
        jobVC.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.viewModel!.sectionsRequiredInTableView()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.viewModel!.rowsRequiredBySection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var jobCell:JobCell = tableView.dequeueReusableCellWithIdentifier("JobCell") as! JobCell
        jobCell.titleLabel.text = self.viewModel!.textForPrimaryLabelAtIndex(indexPath)
        jobCell.subtitleLabel.text = self.viewModel!.textForSecondaryLabelAtIndex(indexPath)
        jobCell.detailLabel.text = self.viewModel!.textForDetailLabelAtIndex(indexPath)
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
            self.tableView?.reloadData()
        }
    }
    func didFinishSearch(){
        NSLog("search complete")
    }


}
