//
//  AppDelegate.swift
//  GithubBrowser
//
//  Created by lex on 04/04/16.
//  Copyright © 2016 Alcherk. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSAppleEventManager.sharedAppleEventManager().setEventHandler(self, andSelector: #selector(AppDelegate.handleEvent(_:withReplyEvent:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }
    
    func handleEvent(event: NSAppleEventDescriptor!, withReplyEvent: NSAppleEventDescriptor!) {
        print("Authorized")
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

