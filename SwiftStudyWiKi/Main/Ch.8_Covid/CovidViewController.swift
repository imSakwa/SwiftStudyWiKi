//
//  CovidViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/03.
//

import UIKit
import SnapKit
import Then
import Alamofire
import Charts

class CovidViewController: UIViewController {

    let stackView1 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    let stackView2 = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 5
    }
    
    let stackView3 = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 5
    }
    
    let domesticLbl = UILabel().then {
        $0.text = "국내 확진자"
    }
    let domesticCntLbl = UILabel().then {
        $0.text = "0명"
    }
    
    let domesticNewLbl = UILabel().then {
        $0.text = "국내 신규 확진자"
    }
    
    let domesticNewCntLbl = UILabel().then {
        $0.text = "0명"
    }
    
    let chartView = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupView()
        
        self.fetchCovidOverview(completionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(result):
                debugPrint("success \(result)")
                
            case let.failure(error):
                debugPrint("failure \(error)")
            }
            
        })
    }
    
    private func fetchCovidOverview(
        completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void
    ) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": "AUS6MojRdvVFi9WZIpucnEGz4eChKys8g"
        ]
        
        AF.request(url, method: .get, parameters: param).responseData(completionHandler: { response in
            switch response.result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CityCovidOverview.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
                
            case let .failure(error):
                completionHandler(.failure(error))
            }
            
        })
    }
    
    private func setupView() {
        view.addSubview(stackView1)
        stackView1.addArrangedSubview(stackView2)
        stackView1.addArrangedSubview(stackView3)
        
        stackView2.addArrangedSubview(domesticLbl)
        stackView2.addArrangedSubview(domesticCntLbl)
        
        stackView3.addArrangedSubview(domesticNewLbl)
        stackView3.addArrangedSubview(domesticNewCntLbl)
        
        view.addSubview(chartView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        stackView1.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        chartView.snp.makeConstraints {
            $0.top.equalTo(stackView1.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}
