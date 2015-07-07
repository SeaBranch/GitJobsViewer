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
        var postingSection:Array<JobPosting> = self.jobPostings[index.section]
        var job:JobPosting = postingSection[index.row]
        return "\(job.title), \(job.company)"
    }
    func textForSecondaryLabelAtIndex(index:NSIndexPath)->String{
        var postingSection:Array<JobPosting> = self.jobPostings[index.section]
        var job:JobPosting = postingSection[index.row]
        return job.location
    }
    
}
