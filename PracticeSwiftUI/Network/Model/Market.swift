//
//  Market.swift
//  PracticeSwiftUI
//
//  Created by 김정윤 on 9/3/24.
//

import Foundation

struct Market: Hashable, Codable {
    let market: String
    let koreanName: String
    let englishName: String
    var isLike = false
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
