//
//  ProductionCompanies.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import Foundation
import ObjectMapper

public final class ProductionCompanies: Mappable, NSCoding {

    // MARK: Struct
  private struct SerializationKeys {
    static let originCountry = "origin_country"
    static let name = "name"
    static let id = "id"
    static let logoPath = "logo_path"
  }

  // MARK: Properties
  public var originCountry: String?
  public var name: String?
  public var id: Int?
  public var logoPath: String?

  // MARK: ObjectMapper Initializers
  public required init?(map: Map){

  }

  public func mapping(map: Map) {
    originCountry <- map[SerializationKeys.originCountry]
    name <- map[SerializationKeys.name]
    id <- map[SerializationKeys.id]
    logoPath <- map[SerializationKeys.logoPath]
  }

  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = originCountry { dictionary[SerializationKeys.originCountry] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = logoPath { dictionary[SerializationKeys.logoPath] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.originCountry = aDecoder.decodeObject(forKey: SerializationKeys.originCountry) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.logoPath = aDecoder.decodeObject(forKey: SerializationKeys.logoPath) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(originCountry, forKey: SerializationKeys.originCountry)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(logoPath, forKey: SerializationKeys.logoPath)
  }

}
