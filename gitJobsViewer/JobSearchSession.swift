//
//  JobSearchSession.swift
//  gitJobsViewer
//
//  Created by NathanWSjoquist on 7/6/15.
//  Copyright (c) 2015 Nathan Sjoquist. All rights reserved.
//

import UIKit

protocol JobSearchRecieverDelegate{
    func didRecieveResults()
    func didFinishSearch()
}
class JobSearchSession: NSObject {
    var jobPostings: Array<Array<JobPosting>>//container for
    let requestString:String//a collected arangement from the base url and requested search terms

    var reciever:JobSearchRecieverDelegate?
    
    var pages = 0//incriments as postings are found in each next page
    let MAXPERPAGE = 50//Max number of postings per page
    
    //the GitRequestManager builds the body of the request string from the search fields and initializes a search session with the requested fields
    required init(requestString:String) {
        assert(requestString != "", "confirm search request not empty")
        self.jobPostings = Array()
        self.requestString = requestString
        super.init()
        self.requestNextPage()
    }
    func requestForNextPage()->NSURLRequest{
        let url = NSURL(string: self.requestString+"&page=\(self.pages)")
        return NSURLRequest(URL: url!)
    }
    
    func requestNextPage(){
        let request:NSURLRequest = self.requestForNextPage()
        
        //create a send task with completion handler and start the "searching" animation
        let task: Void = NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if let dataPullError:NSError = error {
                self.displayErrorAlertForSearchError(dataPullError)
            }else{
                self.handlePageRequestCompletion(data)
            }
        }
    
    }
    
    func displayErrorAlertForSearchError(searchError:NSError){
        UIAlertView(title: "Search Error!", message: searchError.localizedFailureReason!, delegate: self, cancelButtonTitle: "OK").show()
    }
    
    func handlePageRequestCompletion(data:NSData){
        var dataString:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        NSLog("\(dataString)")
        var dataJsons:Array<NSDictionary> = NSJSONSerialization.JSONObjectWithData(data,
            options: NSJSONReadingOptions.MutableContainers,
            error: nil) as! Array<NSDictionary>
        
        if dataJsons.count > 0{//if we have entries for this page
            self.pages++
            var postingSection = Array<JobPosting>()
            for dict:NSDictionary in dataJsons{
                var posting = JobPosting(dict: dict)
                postingSection.append(posting)
            }
            if postingSection.count > 0{
                self.jobPostings.append(postingSection)
            }
            self.reciever!.didRecieveResults()
            
            if dataJsons.count >= self.MAXPERPAGE{//if the count matches the maximum results per page
                //check for any further postings not on this page
                self.requestNextPage()
                
            }else{//no page should follow as this page is not full
                self.reciever?.didFinishSearch()
            }
            
        }else if self.pages == 0{//no results found for this search
            //end animation of search and show no results dialog
            self.reciever?.didFinishSearch()
        }else {//no further results since last page
            //end animation of search
            self.reciever?.didFinishSearch()
        }
    }
}
