//
//  Movie.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import Foundation
import ObjectMapper

public final class Movie: Mappable, NSCoding {

  // MARK: Struct
  private struct SerializationKeys {
    static let budget = "budget"
    static let backdropPath = "backdrop_path"
    static let revenue = "revenue"
    static let voteCount = "vote_count"
    static let overview = "overview"
    static let voteAverage = "vote_average"
    static let video = "video"
    static let imdbId = "imdb_id"
    static let id = "id"
    static let title = "title"
    static let homepage = "homepage"
    static let productionCompanies = "production_companies"
    static let posterPath = "poster_path"
    static let adult = "adult"
    static let genres = "genres"
    static let spokenLanguages = "spoken_languages"
    static let status = "status"
    static let runtime = "runtime"
    static let originalTitle = "original_title"
    static let releaseDate = "release_date"
    static let originalLanguage = "original_language"
    static let popularity = "popularity"
    static let tagline = "tagline"
    static let productionCountries = "production_countries"
  }

  // MARK: Properties
  public var budget: Int?
  public var backdropPath: String?
  public var revenue: Int?
  public var voteCount: Int?
  public var overview: String?
  public var voteAverage: Float?
  public var video: Bool? = false
  public var imdbId: String?
  public var id: Int?
  public var title: String?
  public var homepage: String?
  public var productionCompanies: [ProductionCompanies]?
  public var posterPath: String?
  public var adult: Bool? = false
  public var genres: [Genre]?
  public var spokenLanguages: [SpokenLanguages]?
  public var status: String?
  public var runtime: Int?
  public var originalTitle: String?
  public var releaseDate: String?
  public var originalLanguage: String?
  public var popularity: Float?
  public var tagline: String?
  public var productionCountries: [ProductionCountries]?

  // MARK: ObjectMapper Initializers
  public required init?(map: Map){

  }

  public func mapping(map: Map) {
    budget <- map[SerializationKeys.budget]
    backdropPath <- map[SerializationKeys.backdropPath]
    revenue <- map[SerializationKeys.revenue]
    voteCount <- map[SerializationKeys.voteCount]
    overview <- map[SerializationKeys.overview]
    voteAverage <- map[SerializationKeys.voteAverage]
    video <- map[SerializationKeys.video]
    imdbId <- map[SerializationKeys.imdbId]
    id <- map[SerializationKeys.id]
    title <- map[SerializationKeys.title]
    homepage <- map[SerializationKeys.homepage]
    productionCompanies <- map[SerializationKeys.productionCompanies]
    posterPath <- map[SerializationKeys.posterPath]
    adult <- map[SerializationKeys.adult]
    genres <- map[SerializationKeys.genres]
    spokenLanguages <- map[SerializationKeys.spokenLanguages]
    status <- map[SerializationKeys.status]
    runtime <- map[SerializationKeys.runtime]
    originalTitle <- map[SerializationKeys.originalTitle]
    releaseDate <- map[SerializationKeys.releaseDate]
    originalLanguage <- map[SerializationKeys.originalLanguage]
    popularity <- map[SerializationKeys.popularity]
    tagline <- map[SerializationKeys.tagline]
    productionCountries <- map[SerializationKeys.productionCountries]
  }

  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = budget { dictionary[SerializationKeys.budget] = value }
    if let value = backdropPath { dictionary[SerializationKeys.backdropPath] = value }
    if let value = revenue { dictionary[SerializationKeys.revenue] = value }
    if let value = voteCount { dictionary[SerializationKeys.voteCount] = value }
    if let value = overview { dictionary[SerializationKeys.overview] = value }
    if let value = voteAverage { dictionary[SerializationKeys.voteAverage] = value }
    dictionary[SerializationKeys.video] = video
    if let value = imdbId { dictionary[SerializationKeys.imdbId] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = homepage { dictionary[SerializationKeys.homepage] = value }
    if let value = productionCompanies { dictionary[SerializationKeys.productionCompanies] = value.map { $0.dictionaryRepresentation() } }
    if let value = posterPath { dictionary[SerializationKeys.posterPath] = value }
    dictionary[SerializationKeys.adult] = adult
    if let value = genres { dictionary[SerializationKeys.genres] = value.map { $0.dictionaryRepresentation() } }
    if let value = spokenLanguages { dictionary[SerializationKeys.spokenLanguages] = value.map { $0.dictionaryRepresentation() } }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = runtime { dictionary[SerializationKeys.runtime] = value }
    if let value = originalTitle { dictionary[SerializationKeys.originalTitle] = value }
    if let value = releaseDate { dictionary[SerializationKeys.releaseDate] = value }
    if let value = originalLanguage { dictionary[SerializationKeys.originalLanguage] = value }
    if let value = popularity { dictionary[SerializationKeys.popularity] = value }
    if let value = tagline { dictionary[SerializationKeys.tagline] = value }
    if let value = productionCountries { dictionary[SerializationKeys.productionCountries] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.budget = aDecoder.decodeObject(forKey: SerializationKeys.budget) as? Int
    self.backdropPath = aDecoder.decodeObject(forKey: SerializationKeys.backdropPath) as? String
    self.revenue = aDecoder.decodeObject(forKey: SerializationKeys.revenue) as? Int
    self.voteCount = aDecoder.decodeObject(forKey: SerializationKeys.voteCount) as? Int
    self.overview = aDecoder.decodeObject(forKey: SerializationKeys.overview) as? String
    self.voteAverage = aDecoder.decodeObject(forKey: SerializationKeys.voteAverage) as? Float
    self.video = aDecoder.decodeBool(forKey: SerializationKeys.video)
    self.imdbId = aDecoder.decodeObject(forKey: SerializationKeys.imdbId) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.homepage = aDecoder.decodeObject(forKey: SerializationKeys.homepage) as? String
    self.productionCompanies = aDecoder.decodeObject(forKey: SerializationKeys.productionCompanies) as? [ProductionCompanies]
    self.posterPath = aDecoder.decodeObject(forKey: SerializationKeys.posterPath) as? String
    self.adult = aDecoder.decodeBool(forKey: SerializationKeys.adult)
    self.genres = aDecoder.decodeObject(forKey: SerializationKeys.genres) as? [Genre]
    self.spokenLanguages = aDecoder.decodeObject(forKey: SerializationKeys.spokenLanguages) as? [SpokenLanguages]
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.runtime = aDecoder.decodeObject(forKey: SerializationKeys.runtime) as? Int
    self.originalTitle = aDecoder.decodeObject(forKey: SerializationKeys.originalTitle) as? String
    self.releaseDate = aDecoder.decodeObject(forKey: SerializationKeys.releaseDate) as? String
    self.originalLanguage = aDecoder.decodeObject(forKey: SerializationKeys.originalLanguage) as? String
    self.popularity = aDecoder.decodeObject(forKey: SerializationKeys.popularity) as? Float
    self.tagline = aDecoder.decodeObject(forKey: SerializationKeys.tagline) as? String
    self.productionCountries = aDecoder.decodeObject(forKey: SerializationKeys.productionCountries) as? [ProductionCountries]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(budget, forKey: SerializationKeys.budget)
    aCoder.encode(backdropPath, forKey: SerializationKeys.backdropPath)
    aCoder.encode(revenue, forKey: SerializationKeys.revenue)
    aCoder.encode(voteCount, forKey: SerializationKeys.voteCount)
    aCoder.encode(overview, forKey: SerializationKeys.overview)
    aCoder.encode(voteAverage, forKey: SerializationKeys.voteAverage)
    aCoder.encode(video, forKey: SerializationKeys.video)
    aCoder.encode(imdbId, forKey: SerializationKeys.imdbId)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(homepage, forKey: SerializationKeys.homepage)
    aCoder.encode(productionCompanies, forKey: SerializationKeys.productionCompanies)
    aCoder.encode(posterPath, forKey: SerializationKeys.posterPath)
    aCoder.encode(adult, forKey: SerializationKeys.adult)
    aCoder.encode(genres, forKey: SerializationKeys.genres)
    aCoder.encode(spokenLanguages, forKey: SerializationKeys.spokenLanguages)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(runtime, forKey: SerializationKeys.runtime)
    aCoder.encode(originalTitle, forKey: SerializationKeys.originalTitle)
    aCoder.encode(releaseDate, forKey: SerializationKeys.releaseDate)
    aCoder.encode(originalLanguage, forKey: SerializationKeys.originalLanguage)
    aCoder.encode(popularity, forKey: SerializationKeys.popularity)
    aCoder.encode(tagline, forKey: SerializationKeys.tagline)
    aCoder.encode(productionCountries, forKey: SerializationKeys.productionCountries)
  }

}
