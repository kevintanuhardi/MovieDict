//
//  DetailVC.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 05/07/21.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class DetailVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var movieId : Int?
    
    var detailVM = DetailViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBinding()
        guard let movieId = movieId else {
            return
        }
        detailVM.getMovieDetail(movieId: movieId)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func setupUI() {
        scrollView.contentInsetAdjustmentBehavior = .never
        
        let view = UIView(frame: backdropImage.frame)

        let gradient = CAGradientLayer()

        gradient.frame = view.frame

        gradient.colors = [UIColor.clear.cgColor, UIColor.init(named: "LightBlue")?.cgColor ?? UIColor.white.cgColor]

        gradient.locations = [0.0, 1.0]

        view.layer.insertSublayer(gradient, at: 0)

        backdropImage.addSubview(view)

        backdropImage.bringSubviewToFront(view)
        
        backButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        backButton.layer.cornerRadius = 18
    }
    
    func setupBinding() {
        self.detailVM.movieDetail
          .asObservable()
            .map { $0.title }
          .bind(to:self.titleLabel.rx.text)
          .disposed(by:self.disposeBag)
        
        self.detailVM.movieDetail
          .asObservable()
            .map { $0.runtime }
          .bind(to:self.runtimeLabel.rx.text)
          .disposed(by:self.disposeBag)
        
        self.detailVM.movieDetail
          .asObservable()
            .map { $0.genreList }
          .bind(to:self.genreLabel.rx.text)
          .disposed(by:self.disposeBag)
        
        self.detailVM.movieDetail
          .asObservable()
            .map { $0.overview }
          .bind(to:self.descLabel.rx.text)
          .disposed(by:self.disposeBag)
        
        self.detailVM.movieDetail
          .asObservable()
            .subscribe(onNext: {movie in
                self.backdropImage.sd_setImage(with: URL(string: movie.posterPath), placeholderImage: #imageLiteral(resourceName: "poster-placeholder"))
            })
            .disposed(by:self.disposeBag)

    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
