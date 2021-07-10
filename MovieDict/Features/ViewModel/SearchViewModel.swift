//
//  SearchViewModel.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 07/07/21.
//

import Foundation

import RxSwift
import RxCocoa

class SearchViewModel {
    private let disposable = DisposeBag()
    
    public let searchResult : PublishSubject<[Movie]> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    
    public func searchMovie (searchQuery: String) {
        self.loading.onNext(true)
        APIManager.searchMovie(searchQuery: searchQuery, completion: {result in
            self.loading.onNext(false)
            switch result {
            case .failure(let failure):
                print(failure)
            case .success(let returnJson):
                let movies = returnJson["results"].arrayValue.map{Movie($0)}
                self.searchResult.onNext(movies)
            }
        })
    }
}
