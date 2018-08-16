//
//  ProjectsViewController.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    lazy var projectsViewModel: ProjectsViewModel = {
        return ProjectsViewModel()
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Github Trends"
        tableView.rowHeight = UITableViewAutomaticDimension
        search(with: "swift")
    }
    
    // MARK: - Private API
    fileprivate func search(with term: String) {
        self.tableView.reloadData()
        
        projectsViewModel.fetchProjects(with: term) { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    fileprivate func showProject(_ project: Project) {
        if let toViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ProjectViewController.identifier) as? ProjectViewController {
            toViewController.projectViewModel = ProjectViewModel(project: project)
            navigationController?.pushViewController(toViewController, animated: true)
        }
    }
    
}

extension ProjectsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsViewModel.projectsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath) as! ProjectTableViewCell
        
        cell.project = projectsViewModel.project(at: indexPath)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let project = projectsViewModel.project(at: indexPath) {
            showProject(project)
        }
    }
    
}

extension ProjectsViewController: UISearchBarDelegate {
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(with: searchText)
    }
    
}
