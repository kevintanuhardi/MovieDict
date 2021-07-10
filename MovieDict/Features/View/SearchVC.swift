//
//  SearchVC.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 07/07/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    
    let searchVM = SearchViewModel()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.rx.text.orEmpty
                .debounce(.milliseconds(3000), scheduler: MainScheduler.instance)
                .subscribe(onNext: { [unowned self] (text) in
                    if text.count > 0 {
                        searchVM.searchMovie(searchQuery: text)
                    }
                }).disposed(by: disposeBag)
        
        let movieCellNib = UINib(nibName: "SearchMovieCell", bundle: nil)
        
        searchResultCollectionView.register(movieCellNib, forCellWithReuseIdentifier: "searchMovieCellIdentifier")
        
        searchVM.searchResult.bind(to: searchResultCollectionView.rx.items(cellIdentifier: "searchMovieCellIdentifier", cellType: SearchMovieCell.self)) {  (row, movie, cell) in
            cell.movie = movie
            }.disposed(by: disposeBag)

        searchResultCollectionView
                .rx
            .modelSelected(Movie.self)
                .subscribe(onNext: { (movie) in
                    self.navigateToMovieDetail(movieId: movie.id)
                }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    // MARK: - Navigation

    private func navigateToMovieDetail(movieId: Int) {
        let detailVC = DetailVC()
        detailVC.movieId = movieId
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
