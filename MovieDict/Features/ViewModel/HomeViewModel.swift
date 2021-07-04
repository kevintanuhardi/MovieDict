//
//  HomeViewModel.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 04/07/21.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let popularMovies: PublishSubject<[Movie]> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    public func getPopularMovies () {
        self.loading.onNext(true)
        APIManager.requestData(endpoint: .popularMovies, completion: {result in
            switch result {
            case .failure(let failure):
                print(failure)
            case .success(let returnJson):
                let movies = returnJson["results"].arrayValue.map{Movie($0)}
                self.popularMovies.onNext(movies)
            }
        })
    }
}
