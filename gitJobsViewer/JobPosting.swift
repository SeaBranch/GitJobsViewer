//
//  JobPosting.swift
//  gitJobsViewer
//
//  Created by NathanWSjoquist on 7/6/15.
//  Copyright (c) 2015 Nathan Sjoquist. All rights reserved.
//

import UIKit

class JobPosting: NSObject {
    let title:String//e.g. iOS Developer
    let company:String//e.g. Atomic Robot, LLC
    let location:String//e.g. Mason, OH.
    let jobDescription:String//a job description with links for applications and other job details
    
    //created by the search session using the raw json dictionary data from the api response
    required init(dict:NSDictionary) {
        self.title = dict["title"] as! String
        self.company = dict["company"] as! String
        self.location = dict["location"] as! String
        var jobDescriptionData = dict["description"] as! NSString
        self.jobDescription = JobPosting.formatFromHTMLtoPlainText(jobDescriptionData)//cleanup the text from special characters and html tags
    }
    
    //helper function for description cleanup
    class func formatFromHTMLtoPlainText(str:NSString)->String{
        var str1:NSString = str.stringByReplacingOccurrencesOfString("&#39;", withString: "'", options: NSStringCompareOptions.LiteralSearch, range: NSMakeRange(0, str.length))
        var str2:NSString = str1.stringByReplacingOccurrencesOfString("&nbsp;", withString: "", options: NSStringCompareOptions.LiteralSearch, range: NSMakeRange(0, str1.length))
        let regex:NSRegularExpression  = NSRegularExpression(
            pattern: "<.*?>",
            options: NSRegularExpressionOptions.CaseInsensitive,
            error: nil)!
        let range = NSMakeRange(0, str2.length)
        let htmlLessString :String = regex.stringByReplacingMatchesInString(str2 as String,
            options: NSMatchingOptions.allZeros,
            range:range ,
            withTemplate: "")
        return htmlLessString as String
    }

}
