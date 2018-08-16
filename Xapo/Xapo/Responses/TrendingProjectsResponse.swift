//
//  TrendingProjectsResponse.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct TrendingProjectsResponse: Decodable {
    
    // MARK: - Properties
    var totalCount: Int?
    var items: [Project]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
}
