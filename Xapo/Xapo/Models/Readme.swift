//
//  Readme.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct Readme: Decodable {
    
    // MARK: - Properties
    var url: String?
    var downloadUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "html_url"
        case downloadUrl = "download_url"
    }
    
}
