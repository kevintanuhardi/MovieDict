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
    var genreList: String?
    var posterPath: String
    var backdropPath: String
    var runtime: String?
    
    init(_ json: JSON) {
        id = json["id"].intValue
        title = json["title"].stringValue
        language = json["original_language"].stringValue
        releaseDate = json["release_date"].stringValue
        overview = json["overview"].stringValue
        popularity = json["popularity"].doubleValue
        voteAverage = json["vote_average"].doubleValue
        posterPath = "\(Constants.networking.theMovieDB.imageUrl)/\(json["poster_path"].stringValue)"
        backdropPath = "\(Constants.networking.theMovieDB.imageUrl)/\(json["backdrop_path"].stringValue)"
        
        let runtimeIntValue = json["runtime"].intValue
        runtime = "\(Int(runtimeIntValue / 60))h \(runtimeIntValue % 60)m"
        
        let genreArrValue = json["genres"].arrayValue
        genre = genreArrValue.map{Genre($0)}
        var genreString = String()
        guard let genreArr = genre else{
            return
        }
        let maxGenre = genreArr.count < 2 ? genreArr.count : 2
        for n in 0..<maxGenre {
            genreString += genreArr[n].name
            if n != maxGenre - 1 {
                genreString += " • "
            }
        }
        genreList = genreString
    }
    
}
