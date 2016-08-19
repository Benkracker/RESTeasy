//
//  RERestRequest.swift
//
//  Created by Kracker, Ben on 5/19/16.
//  Copyright © 2016 Ben Kracker. All rights reserved.
//

import Foundation

class RERestRequest {
    
    internal var method: String = ""
    internal var path: String = ""
    internal var endpoint: String = ""
    internal var queryParams: payLoad = [:]
    internal var postData: payLoad = [:]
    internal var useArrayNotation: Bool = false
    
    init(method: String, path: String, endpoint: String, queryParams: payLoad?, postData: payLoad?, useArrayNotation: Bool) {
        self.method = method
        self.path = path
        self.endpoint = endpoint
        self.useArrayNotation = useArrayNotation
        
        if let params: payLoad = queryParams {
            self.queryParams = params
        }
        
        if let data: payLoad = postData {
            self.postData = data
        }
    }
    
    func requestUrl() -> NSURL {
        var urlString = path + endpoint
        
        if queryParams.count > 0 {
            urlString += URLParametersBuilder().URLFormattedStringFromDictionary(queryParams)
        }
        
        let url: NSURL = NSURL(string: urlString)!
        return url
    }
    
    func bodyData() -> (NSData?, NSError?) {
        
        var jsonBody: NSData? = nil
        var resultError: NSError? = nil
        
        if postData.count > 0 {
            do {
                if useArrayNotation {
                    let jsonData = try NSJSONSerialization.dataWithJSONObject([postData], options: NSJSONWritingOptions())
                    jsonBody = jsonData
                } else {
                    let jsonData = try NSJSONSerialization.dataWithJSONObject(postData, options: NSJSONWritingOptions())
                    jsonBody = jsonData
                    
                }
            } catch let error as NSError {
                print(error)
                resultError = error
            }
        }
            
        return (jsonBody, resultError)
    }
    
    func headers() -> [String : String] {
        var headersDict: [String : String] = [:]
        
        headersDict["Content-Type"] = "application/json"
        headersDict["Accept"] = "application/json"
                
        return headersDict
    }
}