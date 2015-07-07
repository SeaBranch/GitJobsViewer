//
//  GitRequestManager.swift
//  gitJobsViewer
//
//  Created by NathanWSjoquist on 7/1/15.
//  Copyright (c) 2015 Nathan Sjoquist. All rights reserved.
//

import UIKit


class GitRequestManager: NSObject {
    
    let baseURL = "https://jobs.github.com/positions.json?"
    var currentSearchSession:JobSearchSession?
    
    func newSearchSessionWithTerms(searchTerm:String?, location:String?)->JobSearchSession?{
        var terms = ""
        if searchTerm != nil{
            var parsedSearchTerms:String = searchTerm!.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.LiteralSearch, range:nil)
            terms += "&description=\(parsedSearchTerms)"
        }
        if location != nil{
            var parsedLocation:String = location!.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.LiteralSearch, range:nil)
            terms += "&location=\(parsedLocation)"
        }
        return JobSearchSession(requestString:"\(baseURL)\(terms)")
    }
}
