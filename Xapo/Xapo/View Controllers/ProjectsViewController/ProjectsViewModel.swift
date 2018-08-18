//
//  ProjectsViewModel.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import Foundation

class ProjectsViewModel {
    
    // MARK: - Properties
    var projects = [Project]()
    var projectsCount: Int {
        return projects.count
    }
    
    // MARK: - Public API
    func fetchProjects(with term: String, _ completion: @escaping () -> ()) {
        let url = "\(apiUrl)\(term)\(query)"
        Logger.log(message: "Fetching from: \(url)", type: .info)
        
        RESTManager.shared.decodableRequest(from: url, method: .get, parameters: nil) { [weak self] (response: TrendingProjectsResponse?) in
            
            if let projects = response?.items {
                Logger.log(message: "Found: \(projects.count) projects", type: .success)
                
                self?.projects = projects
            } else {
                Logger.log(message: "No '\(term)' projects found", type: .debug)
                
                self?.projects.removeAll()
            }
            
            completion()
        }
    }
    
    func project(at indexPath: IndexPath) -> Project? {
        guard indexPath.row <= projectsCount - 1 else { return nil }
        
        return projects[indexPath.row]
    }
    
}
