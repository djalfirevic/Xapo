//
//  Project.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct Project: Decodable {
    
    // MARK: - Properties
    var name: String?
    var description: String?
    var starsCount: Int?
    var forksCount: Int?
    var htmlUrl: String?
    var owner: Owner?
    var readMeUrl: String? {
        guard let username = owner?.username, let name = name else { return nil}
        
        return "https://api.github.com/repos/\(username)/\(name)/readme"
    }
    var stars: String {
        guard let starsCount = starsCount, starsCount > 0 else { return "" }
        
        let suffix = starsCount == 1 ? "star" : "stars"
        
        return "★ \(starsCount) \(suffix)"
    }
    var forks: String {
        guard let forksCount = forksCount, forksCount > 0 else { return "" }
        
        let suffix = forksCount == 1 ? "fork" : "forks"
        
        return "🍴 \(forksCount) \(suffix)"
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case starsCount = "stargazers_count"
        case forksCount = "forks"
        case htmlUrl = "html_url"
        case owner
    }
    
}
