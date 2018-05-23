//
//  SpokenLanguages.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import Foundation
import ObjectMapper

public final class SpokenLanguages: Mappable, NSCoding {

  // MARK: Struct
  private struct SerializationKeys {
    static let iso6391 = "iso_639_1"
    static let name = "name"
  }

  // MARK: Properties
  public var iso6391: String?
  public var name: String?

  // MARK: ObjectMapper Initializers
  public required init?(map: Map){

  }

  public func mapping(map: Map) {
    iso6391 <- map[SerializationKeys.iso6391]
    name <- map[SerializationKeys.name]
  }

  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = iso6391 { dictionary[SerializationKeys.iso6391] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.iso6391 = aDecoder.decodeObject(forKey: SerializationKeys.iso6391) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(iso6391, forKey: SerializationKeys.iso6391)
    aCoder.encode(name, forKey: SerializationKeys.name)
  }

}
