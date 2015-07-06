//
//  GitRequestManager.swift
//  gitJobsViewer
//
//  Created by NathanWSjoquist on 7/1/15.
//  Copyright (c) 2015 Nathan Sjoquist. All rights reserved.
//

import UIKit

protocol SearchDisplayDelegate{
    
}
class GitRequestManager: NSObject {
    var display:SearchDisplayDelegate?
    let baseURL = "https://jobs.github.com/positions.json?"
    var request:NSMutableURLRequest?
    
    override init() {
        
    }
    
    func newSearchSessionWithTerms(searchTerm:String?, location:String?){
        let url: NSURL = NSURL(string: "\(baseURL)&\(searchTerm)")!
        request = NSMutableURLRequest(URL:url)
        var err: NSError?
    }
    
    func dataRecievedFromRequest(){
        var requestReturn = request?.allHTTPHeaderFields
    }
}
