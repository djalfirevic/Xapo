//
//  ProjectViewModel.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import Foundation

class ProjectViewModel {
    
    // MARK: - Properties
    var project: Project?
    var name: String {
        guard let project = project else { return "" }
        
        return project.name ?? "No name"
    }
    var avatarUrl: String? {
        guard let project = project else { return nil }
        
        return project.owner?.avatarUrl
    }
    var username: String {
        return project?.owner?.username ?? ""
    }
    var description: String {
        guard let description = project?.description else { return "" }
        
        return description
    }
    var stars: String {
        guard let project = project else { return "" }
        
        return project.stars
    }
    var forks: String {
        guard let project = project else { return "" }
        
        return project.forks
    }
    var readMeUrlRequest: URLRequest? {
        guard let readMeUrl = readMeUrl else { return nil }
        
        return URLRequest(url: readMeUrl)
    }
    private (set) var readMeUrl: URL?
    
    // MARK: - Initializer
    init(project: Project) {
        self.project = project
    }
    
    // MARK: - Public API
    func fetchReadme(_ completion: @escaping () -> ()) {
        guard let url = project?.readMeUrl else { return }
        
        RESTManager.shared.decodableRequest(from: url, method: .get, parameters: nil) { [weak self] (response: Readme?) in
            
            if let readMeUrl = response?.url {
                Logger.log(message: "Fetching Readme from: \(url)", type: .info)
                
                self?.readMeUrl = URL(string: readMeUrl)!
            }
            
            completion()
        }
    }
    
}
