//
//  HomeTableCell.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import UIKit

class HomeTableCell: UITableViewCell {

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
        imgCheckBox.image = UIImage(named: option.isSelected ? CheckBox.selectedCheck : CheckBox.unSelectedCheck)
    }
}
