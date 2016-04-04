//
//  ViewController.swift
//  GithubBrowser
//
//  Created by lex on 04/04/16.
//  Copyright © 2016 Alcherk. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var loginButton: NSButton!
    @IBOutlet var statusText: NSTextField!
    @IBOutlet var repoTable: NSTableView!

    
    var repos:[RepoEntry] {
        get {
            return GithubManager.sharedInstance.repos
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        //repoTable.hidden = true
        repoTable.setDelegate(self)
        repoTable.setDataSource(self)
    }
        
    @IBAction func loginClick(sender: AnyObject) {
        if (!GithubManager.sharedInstance.hasOAuthToken()) {
            GithubManager.sharedInstance.auth({
                self.listRepos()
            },
            error: { msg in
                self.statusText.stringValue = msg
            });
        }
        else {
            self.listRepos()
        }
    }
    
    func listRepos() {
        GithubManager.sharedInstance.loadRepos({
            self.loginButton.hidden = true
            self.statusText.hidden = true
            self.repoTable.reloadData()
        })
    }    

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

