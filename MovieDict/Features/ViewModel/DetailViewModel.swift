//
//  DetailViewModel.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 06/07/21.
//

import Foundation

import RxSwift
import RxCocoa

class DetailViewModel {
    private let disposable = DisposeBag()
    
    public let movieDetail : PublishSubject<Movie> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    
    public func getMovieDetail (movieId: Int) {
        self.loading.onNext(true)
        APIManager.getMovieDetail(movieId: movieId, completion: {result in
            self.loading.onNext(false)
            switch result {
            case .failure(let failure):
                print(failure)
            case .success(let returnJson):
                self.movieDetail.onNext(Movie(returnJson))
            }
        })
    }
}
