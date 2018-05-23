//
//  AbstractSevice.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import UIKit
import Alamofire

class AbstractRestClient {
    
    typealias RequestManager = (RequestOperationManager!) -> DataRequest
    
    private var requestOperationManager: RequestOperationManager
    
    private static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private static var sharedRequestOperationInstance: RequestOperationManager = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        var headers = RequestOperationManager.defaultHTTPHeaders
        configuration.httpAdditionalHeaders = headers
        
        return RequestOperationManager(configuration: configuration)
    }()
    
    convenience init() {
        self.init(requestOperationManager: AbstractRestClient.sharedRequestOperationInstance)
    }
    
    required init(requestOperationManager: RequestOperationManager) {
        self.requestOperationManager = requestOperationManager
        self.requestOperationManager.startRequestsImmediately = false
    }
    
    func createResourceUrl(resourceUrl: String) -> String {
        return "\(FSUrlHelper.Base_Url)\(resourceUrl)"
    }
    
    func execute(request: (RequestOperationManager!) -> DataRequest) {
        request(self.requestOperationManager).resume()
    }
}
