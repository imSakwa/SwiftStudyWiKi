//
//  AlamofireViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/06/13.
//

import UIKit
import SnapKit
import Then
import Alamofire

class AlamofireViewController: UIViewController {
    private let url = "https://api.corona-19.kr/korea/country/new/"
    private let param = [
        "serviceKey": "AUS6MojRdvVFi9WZIpucnEGz4eChKys8g"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
