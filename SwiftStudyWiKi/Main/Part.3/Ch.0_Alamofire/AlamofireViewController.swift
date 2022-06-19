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
    
    lazy var scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.delegate = self
        $0.bounces = false
    }
    
    let view1 = UIView().then {
        $0.backgroundColor = .systemRed
    }
    
    let view2 = UIView().then {
        $0.backgroundColor = .systemBlue
    }
    
    let view3 = UIView().then {
        $0.backgroundColor = .systemGreen
    }
    
    private var currentPage: CGFloat = 0
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isPortrait {
            print("portarit size: \(size)")
            print("portarit safe Area: \(view.safeAreaLayoutGuide)")
            
        } else if UIDevice.current.orientation.isLandscape {
            print("Landscape size: \(size)")
            print("Landscape safe Area: \(view.safeAreaLayoutGuide)")
            
        }
        scrollView.contentSize = CGSize(width: size.width * 3, height: size.height)
        
        view1.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        view2.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(view1.snp.trailing)
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        view3.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(view2.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        scrollView.setContentOffset(CGPoint(x: size.width * currentPage, y: 0), animated: false)
       
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
                
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 3, height: UIScreen.main.bounds.height)
        
        [view1, view2, view3]
            .forEach {
                scrollView.addSubview($0)
            }
        
        view1.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(UIScreen.main.bounds.height)
        }
        
        view2.snp.makeConstraints {
            $0.leading.equalTo(view1.snp.trailing)
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(UIScreen.main.bounds.height)
        }
        
        view3.snp.makeConstraints {
            $0.leading.equalTo(view2.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(UIScreen.main.bounds.height)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension AlamofireViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width
        
//        print("currentPage : \(currentPage)")
    }
}
