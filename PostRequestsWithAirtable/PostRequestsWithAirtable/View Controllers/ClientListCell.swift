//
//  ClientListCell.swift
//  PostRequestsWithAirtable
//
//  Created by Radharani Ribas-Valongo on 10/31/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ClientListCell: UITableViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var about: UILabel!
    
    
    func configurateCell(type: Clients) {
        self.name.text = type.fields.name
        self.name.numberOfLines = 0
        self.about.text = type.fields.about
        ImageHelper.shared.getImage(urlStr: type.fields.logo?[0].url ?? "") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.logo.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
