//
//  HomeViewController.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 03/07/21.
//

import UIKit
import SwiftyJSON
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
   
    
    @IBOutlet weak var popularMoviesCollectionView: UICollectionView!
    
    var homeViewModel = HomeViewModel()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBindings()
        
        homeViewModel.getPopularMovies()
        
    }
    
    func setupView() {
        popularMoviesCollectionView.backgroundColor = .clear
        let movieCellNib = UINib(nibName: "MovieCell", bundle: nil)
        popularMoviesCollectionView.register(movieCellNib, forCellWithReuseIdentifier: "movieCellIdentifier")
    }
    
    private func setupBindings() {
        
        let movieCellNib = UINib(nibName: "MovieCell", bundle: nil)
        popularMoviesCollectionView.register(movieCellNib, forCellWithReuseIdentifier: "movieCellIdentifier")
        
        homeViewModel.popularMovies.bind(to: popularMoviesCollectionView.rx.items(cellIdentifier: "movieCellIdentifier", cellType: MovieCell.self)) {  (row, movie, cell) in
            cell.movie = movie
            }.disposed(by: disposeBag)

    }
}

//extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCellIdentifier", for: indexPath) as! MovieCell
//        return cell
//    }
//}
