//
//  Constants.swift
//  RestEasy
//
//  Created by Ben Kracker on 8/18/16.
//  Copyright © 2016 Ben Kracker. All rights reserved.
//

import Foundation

typealias payLoad = [String : AnyObject]

struct Constants {

    //The base url that the request will be built with
    struct BaseURL {
        static let url = "paste your url here"
    }
    
    //This should contain a list of endpoints used to post fix the base url for your request
    struct EndPoints {
        
    }
    
    struct RequestMethods {
        static let delete = "DELETE"
        static let get = "GET"
        static let patch = "PATCH"
        static let post = "POST"
        static let put = "PUT"
    }
    
    struct HTTPResponse {
        static let success = ["response" : "success", "code" : 200]
    }
}