//
//  GithubManager.swift
//  GithubBrowser
//
//  Created by lex on 04/04/16.
//  Copyright © 2016 Alcherk. All rights reserved.
//

import Foundation
import OAuth2
import SwiftyJSON
import Alamofire

let settings = [
    "client_id": "insert app id registered at api.github.com",
    "client_secret": "insert client secret here",
    "authorize_uri": "https://github.com/login/oauth/authorize",
    "token_uri": "https://github.com/login/oauth/access_token",
    "scope": "user:email repo",
    "redirect_uris": ["ghbrowser://oauth/callback"],
    "keychain": false
    ] as OAuth2JSON


class RepoEntry: CustomStringConvertible {
    var id: String?
    var name: String?
    var desc: String?
    var url: String?
    
    required init(json: JSON) {
        self.desc = json["description"].string
        self.id = json["id"].string
        self.name = json["name"].string
        self.url = json["url"].string
    }
    
    
    var description: String {
        return "name: \(name)\n\tdescription: \(desc)"
    }
}

class GithubManager {
    let oauth2 : OAuth2
    var repos:Array = Array<RepoEntry>()
    
    static let sharedInstance = GithubManager()
    
    init!() {
        oauth2 = OAuth2CodeGrant(settings: settings)
        
    }
    
    func auth(success: () -> Void, error: (String) -> Void) {
        oauth2.authorizeEmbeddedFrom(0)
        //try! oauth2.openAuthorizeURLInBrowser()
        
        oauth2.onAuthorize = { parameters in
            print("Did authorize with parameters: \(parameters)")
            success()
        }
        oauth2.onFailure = { err in        // `error` is nil on cancel
            let msg: String
            if let err = err {
                msg = "Authorization went wrong: \(err)"
            }
            else {
                msg = "Authorization cancelled"
            }
            print(msg)
            error(msg)
        }
    }
    
    func logout() {
        oauth2.forgetTokens();
    }
    
    func hasOAuthToken() -> Bool
    {
        if let token = oauth2.accessToken
        {
            return !token.isEmpty
        }
        return false
    }
    
    func loadRepos(success: () -> Void) {
        self.repos.removeAll()
        let path = "https://api.github.com/user/repos"
        oauth2.request(.GET, path).responseJSON { response in
            print(response.response) // URL response
            print(response.result)   // result of response serialization
            
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                for (key, jsonRepo) in json
                {
                    print(key)
                    print(jsonRepo)
                    let repo = RepoEntry(json: jsonRepo)
                    self.repos.append(repo)
                }
                success()
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }

}