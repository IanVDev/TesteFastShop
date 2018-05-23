//
//  ProductionCountries.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import Foundation
import ObjectMapper

public final class ProductionCountries: Mappable, NSCoding {

    // MARK: Struct
    private struct SerializationKeys {
    static let name = "name"
    static let iso31661 = "iso_3166_1"
  }

  // MARK: Properties
  public var name: String?
  public var iso31661: String?

  // MARK: ObjectMapper Initializers
  public required init?(map: Map){

  }

  public func mapping(map: Map) {
    name <- map[SerializationKeys.name]
    iso31661 <- map[SerializationKeys.iso31661]
  }

  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = iso31661 { dictionary[SerializationKeys.iso31661] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.iso31661 = aDecoder.decodeObject(forKey: SerializationKeys.iso31661) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(iso31661, forKey: SerializationKeys.iso31661)
  }

}
