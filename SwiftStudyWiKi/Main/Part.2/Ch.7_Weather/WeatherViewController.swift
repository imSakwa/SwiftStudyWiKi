//
//  WeatherViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/03.
//
// 31466ccec95b6097b6411e14edfe9c13
import UIKit
import SnapKit
import Then

class WeatherViewController: UIViewController {
    
    let textField = UITextField().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 6
    }
    
    let btn = UIButton(type: .system).then {
        $0.setTitle("날씨 가져오기", for: .normal)
        $0.addTarget(self, action: #selector(tapFetchWeatherBtn), for: .touchUpInside)
    }
    
    let cityLbl = UILabel().then {
        $0.text = "서울"
        $0.font = .systemFont(ofSize: 26, weight: .regular)
    }
    
    let weatherLbl = UILabel().then {
        $0.text = "맑음"
        $0.font = .systemFont(ofSize: 22, weight: .regular)
    }
    
    let degreeLbl = UILabel().then {
        $0.text = "20도"
        $0.font = .systemFont(ofSize: 32, weight: .bold)
    }
    
    let highLbl = UILabel().then {
        $0.text = "최고 : 20도"
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }
    
    let lowLbl = UILabel().then {
        $0.text = "최저 : 20도"
        $0.font = .systemFont(ofSize: 18, weight: .regular)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupView()
    }
    
    @objc private func tapFetchWeatherBtn(_ sender: UIButton) {
        if let cityName = self.textField.text {
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true)
        }
    }
    
    func getCurrentWeather(cityName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=31466ccec95b6097b6411e14edfe9c13") else { return }
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = (200..<300)
            guard let data = data, error == nil else { return }
            
            let decoder = JSONDecoder()
            
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                
                guard let weatherInformation = try? decoder.decode(WeatherInfomation.self, from: data) else { return }
                
                DispatchQueue.main.async {
                    self?.configureView(weatherInformation: weatherInformation)
                }
                
            } else {
                guard let errorMsg = try? decoder.decode(ErrorMsg.self, from: data) else { return }
                
                DispatchQueue.main.async {
                    self?.showAlert(errorMsg: errorMsg.msg)
                }
            }
            
      
        }.resume()
    }
    
    func configureView(weatherInformation: WeatherInfomation) {
        self.cityLbl.text = weatherInformation.name
        if let weather = weatherInformation.weather.first {
            self.weatherLbl.text = weather.description
        }
        
        self.degreeLbl.text = "\(Int(weatherInformation.temp.temp - 273.15))도"
        self.lowLbl.text = "최저: \(Int(weatherInformation.temp.minTemp - 273.15))도"
        self.highLbl.text = "최고: \(Int(weatherInformation.temp.maxTemp - 273.15))도"
    }
    
    func showAlert(errorMsg: String) {
        let alertView = UIAlertController(title: "ERROR", message: errorMsg, preferredStyle: .alert)
        
        alertView.addAction(UIAlertAction(title: "확인", style: .default))
        
        self.present(alertView, animated: true)
    }
    
    private func setupView() {
        self.view.addSubview(textField)
        self.view.addSubview(btn)
        
        self.view.addSubview(cityLbl)
        self.view.addSubview(weatherLbl)
        self.view.addSubview(degreeLbl)
        self.view.addSubview(highLbl)
        self.view.addSubview(lowLbl)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide
                .snp.top).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        btn.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(25)
        }
        
        cityLbl.snp.makeConstraints {
            $0.top.equalTo(btn.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        weatherLbl.snp.makeConstraints {
            $0.top.equalTo(cityLbl.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        degreeLbl.snp.makeConstraints {
            $0.top.equalTo(weatherLbl.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        highLbl.snp.makeConstraints {
            $0.top.equalTo(degreeLbl.snp.bottom).offset(5)
            $0.trailing.equalTo(degreeLbl.snp.centerX).offset(-5)
        }
        
        lowLbl.snp.makeConstraints {
            $0.top.equalTo(highLbl.snp.top)
            $0.leading.equalTo(degreeLbl.snp.centerX).offset(5)
        }
    }
    


}
