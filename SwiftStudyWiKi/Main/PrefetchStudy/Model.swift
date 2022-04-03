//
//  Model.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/04/03.
//

import Foundation
import UIKit

// 이미지 모델
class Model {
    let url: URL
    
    init(urlStr: String) {
        self.url = URL(string: urlStr)!
    }

}
