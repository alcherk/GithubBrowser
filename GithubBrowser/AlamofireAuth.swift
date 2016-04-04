//
//  AlamofireAuth.swift
//  GithubBrowser
//
//  Created by lex on 04/04/16.
//  Copyright © 2016 Alcherk. All rights reserved.
//

import Alamofire
import OAuth2

extension OAuth2 {
    public func request(
        method: Alamofire.Method,
        _ URLString: URLStringConvertible,
          parameters: [String: AnyObject]? = nil,
          encoding: Alamofire.ParameterEncoding = .URL,
          headers: [String: String]? = nil)
        -> Alamofire.Request
    {
        
        var hdrs = headers ?? [:]
        if let token = accessToken {
            hdrs["Authorization"] = "Bearer \(token)"
        }
        return Alamofire.request(
            method,
            URLString,
            parameters: parameters,
            encoding: encoding,
            headers: hdrs)
    }
}