//
//  TableDelegate.swift
//  GithubBrowser
//
//  Created by lex on 04/04/16.
//  Copyright © 2016 Alcherk. All rights reserved.
//

import Cocoa

extension ViewController : NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return repos.count ?? 0
    }
}

extension ViewController : NSTableViewDelegate {
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text:String = ""
        var cellIdentifier: String = ""
        
        let item = repos[row]
        
        if tableColumn == tableView.tableColumns[0] {
            text = item.name!
            cellIdentifier = "NameCellID"
        } else if tableColumn == tableView.tableColumns[1] {
            text = item.desc!
            cellIdentifier = "UrlCellID"
        }
        
        if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}