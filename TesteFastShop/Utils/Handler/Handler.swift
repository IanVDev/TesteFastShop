//
//  Handler.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import Foundation
import UIKit

class Handler: NSObject {
    
    typealias OnSuccess = (AnyObject?) -> Void
    typealias OnFailure = (Error?) -> Void
    typealias OnDispatch = () -> Void
    typealias OnComplete = () -> Void
    
    private var onSuccess: OnSuccess?
    
    var handlersToBeSkipped = [Handler.Type]()
    
    var onFailure: OnFailure?
    var onDispatch: OnDispatch?
    var onComplete: OnComplete?
    
    func onSuccess(onSuccess: @escaping OnSuccess) -> Self {
        self.onSuccess = onSuccess
        return self
    }
    
    func onFailure(onFailure: @escaping OnFailure) -> Self {
        self.onFailure = onFailure
        return self
    }
    
    func onDispatch(onDispatch: @escaping OnDispatch) -> Self {
        self.onDispatch = onDispatch
        return self
    }
    
    func onComplete(onComplete: @escaping OnComplete) -> Self {
        self.onComplete = onComplete
        return self
    }
    
    func skipHandler(handler: Handler.Type) -> Self {
        if !handlersToBeSkipped.contains(where: { $0 == handler }) {
            handlersToBeSkipped.append(handler)
        }
        return self
    }
    
    func executeOnSuccess(responseObject: AnyObject?, handlers: [Handler]) {
        self.onSuccess?(responseObject)
        executeSuccessHandlers(responseObject: responseObject, handlers: handlers)
    }
    
    func executeSuccessHandlers(responseObject: AnyObject?, handlers: [Handler]) {
        for handler in handlers {
            if !handlersToBeSkipped.contains(where: { $0 == type(of: handler)}) {
                handler.onSuccess?(responseObject)
            }
        }
    }
    
    func executeOnFailure(error: Error!, handlers: [Handler]) {
        self.onFailure?(error)
        for handler in handlers {
            if !handlersToBeSkipped.contains(where: { $0 == type(of: handler)}) {
                handler.onFailure?(error)
            }
        }
    }
    
    func executeOnDispatch(handlers: [Handler]) {
        self.onDispatch?()
        for handler in handlers {
            if !handlersToBeSkipped.contains(where: { $0 == type(of: handler)}) {
                handler.onDispatch?()
            }
        }
    }
    
    func executeOnComplete(handlers: [Handler]) {
        self.onComplete?()
        for handler in handlers {
            if !handlersToBeSkipped.contains(where: { $0 == type(of: handler)}) {
                handler.onComplete?()
            }
        }
    }
}
