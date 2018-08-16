//
//  ProjectTableViewCell.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var project: Project? {
        didSet {
            guard let project = project else { return }
            
            nameLabel.text = project.name ?? ""
            starsCountLabel.text = project.stars
            descriptionLabel.text = project.description ?? ""
        }
    }
    
}
