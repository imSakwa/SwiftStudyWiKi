//
//  Type.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/05.
//

import UIKit

enum `Type` {
    case source
    case target
    
    var color: UIColor {
        switch self {
        case .source: return .label
        case .target: return .mainTintColor
        }
    }
}
