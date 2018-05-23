//
//  MovieList.swift
//  TesteFastShop
//
//  Created by Ian Vilhena on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import UIKit
import ObjectMapper

public final class MovieList: Mappable, NSCoding {
    
    // MARK: Struct
    private struct SerializationKeys {
        static let movies = "results"
    }
    
    // MARK: Properties
    public var movies: [Movie]?
    
    // MARK: ObjectMapper Initializers
    public required init?(map: Map){
        
    }

    public func mapping(map: Map) {
        movies <- map[SerializationKeys.movies]
    }

    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let movies = movies { dictionary[SerializationKeys.movies] = movies }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.movies = aDecoder.decodeObject(forKey: SerializationKeys.movies) as? [Movie]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(movies, forKey: SerializationKeys.movies)
    }
}
