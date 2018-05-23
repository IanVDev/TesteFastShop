//
//  Genres.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import Foundation
import ObjectMapper

public final class Genre: Mappable, NSCoding {

  // MARK: Struct
  private struct SerializationKeys {
    static let id = "id"
    static let name = "name"
  }

  // MARK: Properties
  public var id: Int?
  public var name: String?

  // MARK: ObjectMapper Initializers
  public required init?(map: Map){

  }

  public func mapping(map: Map) {
    id <- map[SerializationKeys.id]
    name <- map[SerializationKeys.name]
  }

  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(name, forKey: SerializationKeys.name)
  }

}
