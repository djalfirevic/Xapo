//
//  Extensions.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func load(from urlString: String?, with placeholder: UIImage?) {
        guard let string = urlString, let url = URL(string: string) else { return }
        image = placeholder
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try Data(contentsOf: url)
                
                if url.absoluteString == string {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            } catch {
                Logger.log(message: "Unable to fetch image", type: .warning)
            }
            
        }
    }
    
}

extension UIViewController {
    
    func presentAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
}
