//
//  MovieService.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import Alamofire
import ObjectMapper

class MovieService: AbstractRestClient {
    
    //MARK: Genres
    func getGenres(handler: ObjectHandler<GenreList>) {
        execute { (request) -> DataRequest in
            let genrerUrl = self.createResourceUrl(resourceUrl: "genre/movie/list")
            let parameters = ["api_key": "1bbcc4ca6c7c3361ce8f33a3c1b3c622",
                              "language": "en-US"]
            return request.getRequest(URLString: genrerUrl, parameters: parameters).responseObjectWithHandler(handler: handler)
        }
    }
    
    //MARK: Movies
    func getMovieListByGenrer(handler: ObjectHandler<MovieList>, genrerId: Int) {
        execute { (request) -> DataRequest in
            let moviesUrl = self.createResourceUrl(resourceUrl: "genre/" + "\(genrerId)" + "/movies")
            let parameters = ["api_key": "1bbcc4ca6c7c3361ce8f33a3c1b3c622",
                              "language": "en-US"]
            return request.getRequest(URLString: moviesUrl, parameters: parameters).responseObjectWithHandler(handler: handler)
        }
    }
}

