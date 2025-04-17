//
//  ContentTableViewCell.swift
//  AssignmentUIKit
//
//  Created by Varun Bhati on 16/04/25.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var fruitImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
