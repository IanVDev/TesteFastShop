//
//  ObjectHandler.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 18/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import Foundation

class ObjectHandler<T>: Handler {
    
    var onSuccess: (T?) -> Void = { (response) in  print("ObjectHandler::onSucess: \(String(describing: response))") }
    
    func onSuccess(success: @escaping ((T?) -> Void)) -> Self {
        self.onSuccess = success
        return self
    }
    
    func executeOnSuccess(responseObject: T?, handlers: [Handler]) {
        self.onSuccess(responseObject)
        if let castedValue: AnyObject = responseObject as AnyObject? {
            executeSuccessHandlers(responseObject: castedValue, handlers: handlers)
        }
    }
}

