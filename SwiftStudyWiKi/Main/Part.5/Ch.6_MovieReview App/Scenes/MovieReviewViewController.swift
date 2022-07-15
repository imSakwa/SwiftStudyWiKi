//
//  MovieReviewViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/15.
//

import UIKit

final class MovieReviewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieSearchManager().request(from: "Starwars") { movies in print(movies)}
    }
}
