//
//  TranslatorManager.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/06.
//

import Foundation
import Alamofire

struct TranslatorManager {
    var sourceLanguage: Language = .ko
    var targetLanguage: Language = .en
    
    func translate(
        from text: String,
        completionHandler: @escaping (String) -> Void
    ) {
        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else { return }
        
        let requestModel = TranslateRequestModel(
            source: sourceLanguage.languageCode,
            target: targetLanguage.languageCode,
            text: text
        )
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "HYUOEAhJJm9bY_cZxx3u",
            "X-Naver-Client-Secret": "Sq1BwRHHpt"
        ]
        
        AF
            .request(url, method: .post, parameters: requestModel, headers: headers)
            .responseDecodable(of: TranslateResponseModel.self) { response in
                switch response.result {
                case .success(let result): completionHandler(result.translatedText)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
        
    }
}
