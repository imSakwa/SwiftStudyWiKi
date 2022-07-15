//
//  MovieSearchManager.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/15.
//

import Foundation
import Alamofire

protocol MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping (([Movie]) -> Void))
}

struct MovieSearchManager: MovieSearchManagerProtocol {
    func request(from keyword: String, completionHandler: @escaping (([Movie]) -> Void)) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else { return }
        
        let parameters = MovieSearchRequestModel(query: keyword)
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : "udoIukYR5rEmo2Jq6XDE",
            "X-Naver-Client-Secret" : "TO0ZfwzBvM"
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: header
        )
        .responseDecodable(of: MovieSearchResponseMoel.self) { response in
            switch response.result {
            case .success(let result):
                completionHandler(result.items)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
