//
//  ChildCell.swift
//  ParentApp
//
//  Created by Pavel Razumov on 27.07.2023.
//

import UIKit

class ChildCell: UITableViewCell {
    
    static let reuseID = "childCell"
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
