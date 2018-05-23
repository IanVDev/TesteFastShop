//
//  RequestOperationManager.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 18/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

public let UnauthorizedRequestOperation: String = "RequestOperationManagerUnauthorizedRequestOperation"

class RequestOperationManager: Alamofire.SessionManager {
    
    static var handlers: [Handler] = [Handler]()
    
    var userSessionHeader: [String : String]?
    
    func newAuthenticatedRequest(method: Alamofire.HTTPMethod, _ URLString: URLConvertible, parameters: [String: Any]? = nil, encoding: ParameterEncoding, headerForRotateUser: String? = nil) -> DataRequest {
        return newRequest(method: method, URLString, parameters: parameters, encoding: encoding, authenticated: true, headerForRotateUser: headerForRotateUser)
    }
    
    func newRequest(method: Alamofire.HTTPMethod, _ URLString: URLConvertible, parameters: [String: Any]? = nil, encoding: ParameterEncoding) -> DataRequest {
        return newRequest(method: method, URLString, parameters: parameters, encoding: encoding, authenticated: false)
    }
    
    // This function return a new AUTHENTICATED GET request, creating a query
    //string with parameters to be set as or appended to any existing URL query
    func authenticatedGetRequest(URLString: URLConvertible, parameters: [String: Any]? = nil) -> DataRequest {
        return newAuthenticatedRequest(method: .get, URLString, parameters: parameters, encoding: URLEncoding.default)
    }
    
    // This function return a new AUTHENTICATED DELETE request, creating a query
    // string to be set as or appended to any existing URL query
    func authenticatedDeleteRequest(URLString: URLConvertible, parameters: [String: Any]? = nil) -> DataRequest {
        return newAuthenticatedRequest(method: .delete, URLString, parameters: parameters, encoding: URLEncoding.default)
    }
    
    // This function return a new AUTHENTICATED POST request, creating a JSON
    // representation of the parameters object, which is set as the body of the request
    func authenticatedPostRequest(URLString: URLConvertible, parameters: [String: Any]? = nil, headerForRotateUser: String? = nil) -> DataRequest {
        return newAuthenticatedRequest(method: .post, URLString, parameters: parameters, encoding: JSONEncoding.default, headerForRotateUser: headerForRotateUser)
    }
    
    // This function return a new AUTHENTICATED PUT request, creating a JSON
    // representation of the parameters object, which is set as the body of the request
    func authenticatedPutRequest(URLString: URLConvertible, parameters: [String: Any]? = nil) -> DataRequest {
        return newAuthenticatedRequest(method: .put, URLString, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    // This function return a new GET request, creating a query
    // string with parameters to be set as or appended to any existing URL query
    func getRequest(URLString: URLConvertible, parameters: [String: Any]? = nil) -> DataRequest {
        return newRequest(method: .get, URLString, parameters: parameters, encoding: URLEncoding.default)
    }
    
    // This function return a new POST request, creating a JSON
    // representation of the parameters object, which is set as the body of the request
    func postRequest(URLString: URLConvertible, parameters: [String: Any]? = nil) -> DataRequest {
        return newRequest(method: .post, URLString, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    // This function return a new POST request, creating a query
    // string to be set as or appended to any existing URL query
    func postURLEncondedRequest(URLString: URLConvertible, parameters: [String: Any]? = nil) -> DataRequest {
        return newRequest(method: .post, URLString, parameters: parameters, encoding: URLEncoding.default)
    }
    
    private func newRequest(method: Alamofire.HTTPMethod, _ URLString: URLConvertible, parameters: [String: Any]? = nil, encoding: ParameterEncoding, authenticated: Bool, headerForRotateUser: String? = nil) -> DataRequest {
        do {
            let cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy
            var urlRequest: URLRequest!
            if let url = URL(string: URLString as! String) {
                urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 30)
            } else {
                urlRequest =  URLRequest(url: URL(string: "www.google.com")!, cachePolicy: cachePolicy, timeoutInterval: 30)
            }
            
            urlRequest.httpMethod = method.rawValue
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

            urlRequest.setValue(NSLocale.preferredLanguages.first?.capitalized.lowercased(), forHTTPHeaderField: "Preferred-Language")
            
            let urlRequestEncoded = try encoding.encode(urlRequest, with: parameters)
            print("REQUEST CALLED: \(urlRequestEncoded)")
            return request(urlRequestEncoded)
   
        }
        catch {
            return request("")
        }
    }
}

extension DataRequest {
    func onDispatchRequestHandler(handler: Handler) {
        handler.executeOnDispatch(handlers: RequestOperationManager.handlers)
    }
    
    func onFailureRequestHandler(error: Error?, handler: Handler) {
        handler.executeOnFailure(error: error, handlers: RequestOperationManager.handlers)
        handler.executeOnComplete(handlers: RequestOperationManager.handlers)
    }
    
    public func responseArray<T: Mappable>(completionHandler: @escaping (URLRequest, HTTPURLResponse?, [T]?, Error?) -> Void) -> Self {
        return responseArray(queue: nil, completionHandler: completionHandler)
    }
    
    public func responseArray<T: Mappable>(queue: DispatchQueue?, completionHandler: @escaping (URLRequest, HTTPURLResponse?, [T]?, Error?) -> Void) -> Self {
        
        let serializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
        
        return response(queue: queue, responseSerializer: serializer) { (Response) -> Void in
            if Response.result.isSuccess {
                if let results = Response.result.value {
                    let parsedObject = Mapper<T>().mapArray(JSONObject: results)
                    completionHandler(Response.request!, Response.response, parsedObject, nil)
                } else {
                    let parsedObject = Mapper<T>().mapArray(JSONObject: Response.result.value)
                    completionHandler(Response.request!, Response.response, parsedObject, nil)
                }
            } else {
                if Response.response?.statusCode == 401 {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: UnauthorizedRequestOperation), object: ["request": Response.request!, "response": Response.response!])
                }
                completionHandler(Response.request!, Response.response, nil, Response.result.error)
            }
        }
    }
    
    public func responseDataObject<T: Mappable>(queue: DispatchQueue?, completionHandler: @escaping (URLRequest, HTTPURLResponse?, T?, Error?) -> Void) -> Self {
        let serializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
        
        return response(queue: queue, responseSerializer: serializer) { (Response) -> Void in
            if Response.result.isSuccess {
                if let value = Response.result.value {
                        let parsedObject = Mapper<T>().map(JSONObject: value)
                        return completionHandler(Response.request!, Response.response, parsedObject, nil)
                }
                else {
                    return completionHandler(Response.request!, Response.response, nil, Response.result.error)
                }
            } else {
                if Response.response?.statusCode == 401 {
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: UnauthorizedRequestOperation), object: ["request": Response.request!, "response": Response.response!])
                }
                completionHandler(Response.request!, Response.response, nil, Response.result.error)
            }
        }
    }

    func responseCollectionWithHandler<T: Mappable>(handler: ObjectCollectionHandler<T>) -> Self {
        onDispatchRequestHandler(handler: handler)
        return self.responseArray(completionHandler: onCompletionRequestObjectCollectionHandler(handler: handler))
    }
    
    private func onCompletionRequestObjectCollectionHandler<T>(handler: ObjectCollectionHandler<T>) -> ((URLRequest, HTTPURLResponse?, [T]?, Error?) -> Void) {
        return { (request, response, object: [T]?, error) in
            
            if let error = error {
                self.onFailureRequestHandler(error: error, handler: handler)
            } else {
                handler.executeOnSuccess(responseObject: object, handlers: RequestOperationManager.handlers)
                handler.executeOnComplete(handlers: RequestOperationManager.handlers)
            }
        }
    }
    
    public func responseObject<T: Mappable>(completionHandler: @escaping (URLRequest, HTTPURLResponse?, T?, Error?) -> Void) -> Self {
        return responseObject(queue: nil, completionHandler: completionHandler)
    }
    
    public func responseDataObject<T: Mappable>(completionHandler: @escaping (URLRequest, HTTPURLResponse?, T?, Error?) -> Void) -> Self {
        return responseDataObject(queue: nil, completionHandler: completionHandler)
    }
    
    public func responseObject<T: Mappable>(queue: DispatchQueue?, completionHandler: @escaping (URLRequest, HTTPURLResponse?, T?, Error?) -> Void) -> Self {
        let serializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
        
        return response(queue: queue, responseSerializer: serializer) { (Response) -> Void in
            if Response.result.isSuccess {
                if let value = Response.result.value {
                    let parsedObject = Mapper<T>().map(JSON: (value as? [String: Any])!)
                    completionHandler(Response.request!, Response.response, parsedObject, Response.result.error)
                    print(Response.result.value as Any)
                }
            } else {
                if Response.response?.statusCode == 401 {
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: UnauthorizedRequestOperation), object: ["request": Response.request!, "response": Response.response!])
                }
                completionHandler(Response.request!, Response.response, nil, Response.result.error)
            }
        }
    }
    
    func responseObjectWithHandler<T: Mappable>(handler: ObjectHandler<T>) -> Self {
        onDispatchRequestHandler(handler: handler)
        return self.responseObject(completionHandler: onCompletionRequestObjectHandler(handler: handler))
    }
    
    func responseDataObjectWithHandler<T: Mappable>(handler: ObjectHandler<T>) -> Self {
        onDispatchRequestHandler(handler: handler)
        return self.responseDataObject(completionHandler: onCompletionRequestObjectHandler(handler: handler))
    }
    //
    func onCompletionRequestObjectHandler<T>(handler: ObjectHandler<T>) -> ((URLRequest, HTTPURLResponse?, T?, Error?) -> Void) {
        return { (request, response, object: T?, error) in
            if (error == nil) {
                handler.executeOnSuccess(responseObject: object, handlers: RequestOperationManager.handlers)
                handler.executeOnComplete(handlers: RequestOperationManager.handlers)
            } else {
                self.onFailureRequestHandler(error: error, handler: handler)
            }
        }
    }
}
