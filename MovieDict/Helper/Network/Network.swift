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
        case nowPlayingMovies
        case movieDetail(id: Int)
        
        public var url: String {
            let MDBbaseUrl = Constants.networking.theMovieDB.baseUrl
            let MDBapiKey = Constants.networking.theMovieDB.apiKey
            switch self {
            case .popularMovies: return
                "\(MDBbaseUrl)3/movie/popular?api_key=\(MDBapiKey)&language=en-US&include_adult=false&page=1"
            case .nowPlayingMovies: return
                "\(MDBbaseUrl)3/movie/now_playing?api_key=\(MDBapiKey)&language=en-US&include_adult=false&page=1"
            case .movieDetail(let id): return
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
    
    static func getMovieDetail(movieId: Int, completion: @escaping (ApiResult)->Void ) {
        AF.request(Endpoints.movieDetail(id: movieId).url)
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
    
    static func getPopularMovies(completion: @escaping (ApiResult)->Void ) {
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
    
    static func getNPMovies(completion: @escaping (ApiResult)->Void ) {
        AF.request(Endpoints.nowPlayingMovies.url)
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
