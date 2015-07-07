//
//  gitJobsViewerTests.swift
//  gitJobsViewerTests
//
//  Created by NathanWSjoquist on 7/1/15.
//  Copyright (c) 2015 Nathan Sjoquist. All rights reserved.
//

import UIKit
import XCTest

class gitJobsViewerTests: XCTestCase, JobSearchRecieverDelegate{
    var manager:GitRequestManager?
    var testSession:JobSearchSession?
    var topPosting:JobPosting?
    
    override func setUp() {
        super.setUp()
        manager = GitRequestManager()
        self.testSession = manager?.newSearchSessionWithTerms("iOS", location:nil)
        self.testSession!.reciever = self
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStartupWithManager(){
        XCTAssert(manager != nil, "Manager Creation Test Passed")
    }
    func testSearchCreationTL(){
        var session = manager?.newSearchSessionWithTerms("iOS", location: "Cincinnati")
        XCTAssert(session != nil, "Session Creation Test One(Two Fields) Passed")
    }
    func testSearchCreationT(){
        var session = manager?.newSearchSessionWithTerms("iOS", location:nil)
        XCTAssert(session != nil, "Session Creation Test Two(term only) Passed")
    }
    func testSearchCreationL(){
        var session = manager?.newSearchSessionWithTerms(nil, location: "Cincinnati")
        XCTAssert(session != nil, "Session Creation Test Three(location only) Passed")
    }
    
    func testDidRecieveResults() {
        var expectation = expectationForNotification("didRecieveResults", object: nil, handler: nil)
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    func testDidFinishSearch() {
        var expectation = expectationForNotification("didFinishSearch", object: nil, handler: nil)
        waitForExpectationsWithTimeout(30, handler: nil)
    }
    func testHandleSearchResults(){
        var expectationForResults = expectationForNotification("jopPostingsFound", object: nil, handler: nil)
        waitForExpectationsWithTimeout(30, handler: nil)
    }
    func testCreateJobPostingsFromData(){
        var expectationForResults = expectationForNotification("jobDescriptionFoundNotEmpty", object: nil, handler: nil)
        waitForExpectationsWithTimeout(30, handler: nil)
    }
    
    
    func didRecieveResults() {
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "didRecieveResults", object: nil))
        if self.testSession?.jobPostings.count > 0{
            NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "jopPostingsFound", object: nil))
            self.topPosting = (self.testSession!.jobPostings[0])[0]
            var posting:JobPosting = self.topPosting!
            NSLog("Top posting has T:\(posting.title) C:\(posting.company) L:\(posting.location)\nD:\(posting.jobDescription)")
            if posting.jobDescription != ""{
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "jobDescriptionFoundNotEmpty", object: nil))
            }
        }
    }
    func didFinishSearch() {
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "didFinishSearch", object: nil))
    }
    
}
