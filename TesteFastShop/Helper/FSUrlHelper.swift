//
//  FSHelper.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import UIKit

class FSUrlHelper: NSObject {
    
    static let Base_Url = FSUrlHelper.sharedInstance.stringURL(key: "base_url")
    
    static let sharedInstance = FSUrlHelper()
    
    private let serviceEnvironment = "Service Environment"
    
    private let serviceEnvironmentDevelopment = "isDevelopment"
    private let developmentPlist = "development-urls"
    
    internal func stringURL(key: String) -> String {
        let environments = Bundle.main.object(forInfoDictionaryKey: serviceEnvironment)
        assert(environments != nil, "INVALID ENVIRONMENT: invalid plist (no \"WS Environments\" key!")
        if let dict = environments as? Dictionary<String, Any> {
            let development = dict[serviceEnvironmentDevelopment] as? Bool
            
            let anyNil = development == nil
            assert(!anyNil, "INVALID ENVIRONMENT: keys not found!")
            
            var plistName : String = "invalid-urls"
            if (development == true) { plistName = developmentPlist }
            
            if let path = Bundle.main.path(forResource: plistName, ofType: "plist") {
                if let urlPlist = NSDictionary(contentsOfFile: path) {
                    return urlPlist[key] as! String
                }
            }
        }
        assert(false, "INVALID ENVIRONMENT: unknown error, url not found")
        return "invalidURL"
    }
    
    static func urlForKey(key: String) -> NSURL {
        return NSURL(string: key)!
    }
}

