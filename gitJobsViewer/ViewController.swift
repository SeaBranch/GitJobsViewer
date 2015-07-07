//
//  ViewController.swift
//  gitJobsViewer
//
//  Created by NathanWSjoquist on 7/1/15.
//  Copyright (c) 2015 Nathan Sjoquist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var requesturl :NSURL = NSURL(string: "http://jobs.github.com/positions.json?description=ios+Developer&page=0")!
        var request: NSURLRequest = NSURLRequest(URL: requesturl)
       // NSLog("REQUEST ^{^\(request)^}^")
        let task = NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            var dataError = NSError()
            var dataString:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var parsedStr = self.removeStringsFromString(dataString, stringsToRemove: ["<p>","</p>","\n","<ul>","</ul>","<li>","</li>"])
            
            var dataJson:Array<NSDictionary> = NSJSONSerialization.JSONObjectWithData(data,
                options: NSJSONReadingOptions.MutableContainers,
                error: nil) as! Array<NSDictionary>
            NSLog("page search done")
            for dict:NSDictionary in dataJson{
                var company = dict["company"] as! String
                var title = dict["title"] as! String
                var location = dict["location"] as! String
                var jobDescriptionData = (dict["description"] as! String)
                var jobDescription = self.formatFromHTMLtoPlainText(jobDescriptionData) as String//self.removeStringsFromString(jobDescriptionData, stringsToRemove:["<p>","</p>","<em>","</em>","<ul>","</ul>","<li>","</li>"])
                
                //NSLog("company:\(company),title:\(title),loc:\(location),\n description:\(jobDescription)")
            }
            //NSLog("\(dataJson)")
        }/*NSURLSession.sharedSession().dataTaskWithURL(requesturl) {(data, response, error) in
            var dataj = NSString(data: data, encoding: NSUTF8StringEncoding)
            var json = NSJSONSerialization.JSONObjectWithData(dataj!, options: NSJSONReadingOptions.allZeros, error: error)
            NSLog("RR::: \(response)")
        }*/
        
        //task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func removeStringsFromString(original:NSString, stringsToRemove:Array<NSString>)->NSString{
        var product:NSString = original
        for remStr:NSString in stringsToRemove{
            product = product.stringByReplacingOccurrencesOfString(remStr as String, withString: "")
        }
        return product
    }
    func formatFromHTMLtoPlainText(str:NSString)->String{
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

