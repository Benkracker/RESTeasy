//
//  URLParametersBuilder.swift
//
//  Created by Kracker, Ben on 5/20/16.
//  Copyright © 2016 Ben Kracker. All rights reserved.
//

import Foundation

class URLParametersBuilder {
    
    func URLFormattedStringFromDictionary(dictionary: [String : AnyObject]) -> String {
        
        let urlStrings = URLArrayFromDictionary(dictionary)
        let urlString = "?" + urlStrings.joinWithSeparator("&")
        
        return urlString
    }
    
    private func URLArrayFromDictionary(dictionary: [String : AnyObject]) -> [String] {
        var urlArray: [String] = []
        
        for (key, value) in dictionary {
            if let condition: String = key + "=" + (value as! String) {
                urlArray.append(condition)
            }
        }
        
        return urlArray
    }
    
}