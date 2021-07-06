//
//  DetailVC.swift
//  MovieDict
//
//  Created by Kevin Tanuhardi on 05/07/21.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backdropImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentInsetAdjustmentBehavior = .never
        
        let view = UIView(frame: backdropImage.frame)

        let gradient = CAGradientLayer()

        gradient.frame = view.frame

        gradient.colors = [UIColor.clear.cgColor, UIColor.init(named: "LightBlue")?.cgColor]

        gradient.locations = [0.0, 1.0]

        view.layer.insertSublayer(gradient, at: 0)

        backdropImage.addSubview(view)

        backdropImage.bringSubviewToFront(view)
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

}
