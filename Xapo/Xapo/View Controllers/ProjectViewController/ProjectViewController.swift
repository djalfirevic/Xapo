//
//  ProjectViewController.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import UIKit
import WebKit

class ProjectViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var readmeWebView: WKWebView!
    var projectViewModel: ProjectViewModel!
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // MARK: - Private API
    fileprivate func updateUI() {
        infoContainerView.layer.cornerRadius = 2
        infoContainerView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        infoContainerView.layer.borderWidth = 1
        
        title = projectViewModel.username
        avatarImageView.load(from: projectViewModel.avatarUrl, with: #imageLiteral(resourceName: "octocat"))
        usernameLabel.text = projectViewModel.username
        descriptionTextView.text = projectViewModel.description
        starsLabel.text = projectViewModel.stars
        forksLabel.text = projectViewModel.forks
        
        projectViewModel.fetchReadme {
            if let request = self.projectViewModel.readMeUrlRequest {
                self.readmeWebView.load(request)
            }
        }
    }

}