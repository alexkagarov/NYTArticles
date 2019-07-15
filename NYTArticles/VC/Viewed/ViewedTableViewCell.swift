//
//  ViewedTableViewCell.swift
//  NYTArticles
//
//  Created by Alex Kagarov on 7/9/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import UIKit

class ViewedTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    // MARK: - Cell life-cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
