//
//  Level.swift
//  saolei
//
//  Created by 杨立鹏 on 2021/1/27.
//

import Foundation

enum Level: Int {
    case junior = 0
    case middle = 1
    case senior = 2

    var column: Int {
        switch self {
        case .junior:
            return 9
        case .middle:
            return 16
        default:
            return 16
        }
    }

    var row: Int {
        switch self {
        case .junior:
            return 9
        case .middle:
            return 16
        default:
            return 30
        }
    }

    var bombCount: Int {
        switch self {
        case .junior:
            return 10
        case .middle:
            return 40
        default:
            return 99
        }
    }
}
