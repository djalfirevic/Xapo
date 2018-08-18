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
        
        RESTManager.shared.decodableRequest(from: url, method: .get, parameters: nil) { [weak self] (response: TrendingProjectsResponse?) in
            if let projects = response?.items {
                Logger.log(message: "Fetching from: \(url)", type: .info)
                Logger.log(message: "Found: \(projects.count) projects", type: .info)
                
                self?.projects = projects
            }
            
            completion()
        }
    }
    
    func project(at indexPath: IndexPath) -> Project? {
        guard indexPath.row <= projectsCount - 1 else { return nil }
        
        return projects[indexPath.row]
    }
    
}
