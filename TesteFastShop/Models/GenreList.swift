//
//  GenreList.swift
//  TesteFastShop
//
//  Created by Ian Vilhena on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import UIKit
import ObjectMapper

public final class GenreList: Mappable, NSCoding {
    
    // MARK: Struct
    private struct SerializationKeys {
        static let genres = "genres"
    }
    
    // MARK: Properties
    public var genres: [Genre]?
    
    public required init?(map: Map){
        
    }

    public func mapping(map: Map) {
        genres <- map[SerializationKeys.genres]
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let genres = genres { dictionary[SerializationKeys.genres] = genres }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.genres = aDecoder.decodeObject(forKey: SerializationKeys.genres) as? [Genre]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(genres, forKey: SerializationKeys.genres)
    }
    
}
