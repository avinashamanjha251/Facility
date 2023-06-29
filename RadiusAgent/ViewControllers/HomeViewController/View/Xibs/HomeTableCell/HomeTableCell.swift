//
//  HomeTableCell.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import UIKit

class HomeTableCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgCheckBox: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellUI(option: CMOption) {
        lblTitle.text = option.name
        imgIcon.image = UIImage(named: option.icon)
        imgCheckBox.image = UIImage(named: option.isSelected ? CheckBox.selectedCheck : CheckBox.unSelectedCheck)
    }
    
    func configureCellUI(exclusionOption: CMExclusionOption) {
        lblTitle.text = exclusionOption.name
        imgIcon.image = UIImage(named: exclusionOption.icon)
        imgCheckBox.image = UIImage(named: exclusionOption.isSelected ? CheckBox.selectedCheck : CheckBox.unSelectedCheck)
    }
}
