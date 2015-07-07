//
//  SearchResultsViewModel.swift
//  gitJobsViewer
//
//  Created by NathanWSjoquist on 7/7/15.
//  Copyright (c) 2015 Nathan Sjoquist. All rights reserved.
//

import UIKit

class SearchResultsViewModel: NSObject {
    
    var jobPostings:Array<Array<JobPosting>>
    
    override init() {
        self.jobPostings = Array()
    }
    func clearData(){
        self.jobPostings = Array()
    }
    func appendData(newData:Array<JobPosting>){
        self.jobPostings.append(newData)
    }
    
    func sectionsRequiredInTableView()->Int{
        return jobPostings.count
    }
    func rowsRequiredBySection(section:Int)->Int{
        if self.jobPostings.count > section{
            let postingSection:Array<JobPosting> = self.jobPostings[section]
            return postingSection.count
        }else {
            return 0
        }
    }
    
    
    func textForPrimaryLabelAtIndex(index:NSIndexPath)->String{
        var job:JobPosting = self.jobForIndex(index)
        return job.title
    }
    func textForSecondaryLabelAtIndex(index:NSIndexPath)->String{
        var job:JobPosting = self.jobForIndex(index)
        return job.company
    }
    func textForDetailLabelAtIndex(index:NSIndexPath)->String{
        var job:JobPosting = self.jobForIndex(index)
        return job.location
    }
    func jobForIndex(index:NSIndexPath)->JobPosting{
        var postingSection:Array<JobPosting> = self.jobPostings[index.section]
        return postingSection[index.row]
    }
    
}
