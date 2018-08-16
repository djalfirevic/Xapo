//
//  Owner.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    
    // MARK: - Properties
    var username: String?
    var avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarUrl = "avatar_url"
    }
    
}
