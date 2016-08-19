//
//  RERestHandler.swift
//
//  Created by Kracker, Ben on 5/19/16.
//  Copyright © 2016 Ben Kracker. All rights reserved.
//

import Foundation

class RestHandler {
    
    func sendWithRequest(restRequest: RERestRequest, completion: (result: [payLoad]) -> Void, failure: (error: NSError) -> Void) -> Void {
        
        let urlRequest: NSMutableURLRequest = request(restRequest.requestUrl(), type: restRequest.method, headers: restRequest.headers())
        let possibleData = restRequest.bodyData()
        if possibleData.0 != nil {
            urlRequest.HTTPBody = possibleData.0
        }
        
        sendRequest(urlRequest, completion: { (result) in
            completion(result: result)
            }) { (error) in
                failure(error: error)
        }
    }
    
    private func sendRequest(urlRequest: NSURLRequest, completion: (result: [payLoad]) -> Void, failure: (error: NSError) -> Void) {
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest){ data, response, error in
            if error != nil{
                failure(error: error!)
            }
            
            if data != nil {
                do {
                    if let jsonData: [payLoad] = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? [payLoad] {
                        completion(result: jsonData)
                    }
                } catch let error as NSError {
                    if let httpResponse = response as? NSHTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            completion(result: [Constants.HTTPResponse.success])
                            return
                        }
                    }
                    failure(error: error)
                }
            }
        }
            
        task.resume()
    }
    
    private func request(url: NSURL, type: String, headers: [String : String]) -> NSMutableURLRequest {
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
        
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.HTTPMethod = type
        
        return urlRequest
    }
    
}