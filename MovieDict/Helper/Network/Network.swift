//
//  Network.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 04/07/21.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Endpoints{
        case popularMovies
        case detailMovie(id: Int)
        
        public var url: String {
            let MDBbaseUrl = Constants.networking.theMovieDB.baseUrl
            let MDBapiKey = Constants.networking.theMovieDB.apiKey
            switch self {
            case .popularMovies: return
                "\(MDBbaseUrl)3/discover/movie?api_key=\(MDBapiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
            case .detailMovie(let id): return
                "\(MDBbaseUrl)3/movie/\(id)?api_key=\(MDBapiKey)&language=en-US"
            }
        }
}

class APIManager {
    
    enum RequestError: Error {
        case unknownError
        case connectionError
        case authorizationError(JSON)
        case invalidRequest
        case notFound
        case invalidResponse
        case serverError
        case serverUnavailable
    }
    
    enum ApiResult {
        case success(JSON)
        case failure(RequestError)
    }
    
    static func requestData(endpoint: Endpoints, completion: @escaping (ApiResult)->Void) {
        AF.request(Endpoints.popularMovies.url)
            .validate()
            .responseJSON{ json in
                switch json.result {
                case .failure:
                    completion(ApiResult.failure(.connectionError))
                case .success(let jsonData):
                    if let json = try? JSONSerialization.data(withJSONObject: jsonData, options: .sortedKeys) {
                        do {
                            let data = try JSON(data: json)
                            completion(ApiResult.success(data))
                        } catch {
                            completion(ApiResult.failure(.connectionError))
                        }
                    } else {
                        completion(ApiResult.failure(.connectionError))
                    }
                    
                    
                }
                    
            }
    }
}
