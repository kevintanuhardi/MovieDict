//
//  Movie.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 04/07/21.
//

import Foundation
import SwiftyJSON

struct Movie {
    
    var id: Int
    var title : String
    var language : String
    var releaseDate: String
    var overview: String
    var popularity: Double
    var voteAverage: Double
    var genre: [Genre]?
    var posterPath: String
    var backdropPath: String
    
    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        language = json["original_language"].stringValue
        releaseDate = json["release_date"].stringValue
        overview = json["overview"].stringValue
        popularity = json["popularity"].doubleValue
        voteAverage = json["vote_average"].doubleValue
//        genre = json["genre"].stringValue
        posterPath = "\(Constants.networking.theMovieDB.imageUrl)/\(json["poster_path"].stringValue)"
        backdropPath = "\(Constants.networking.theMovieDB.imageUrl)/\(json["backdrop_path"].stringValue)"
    }
    
}
