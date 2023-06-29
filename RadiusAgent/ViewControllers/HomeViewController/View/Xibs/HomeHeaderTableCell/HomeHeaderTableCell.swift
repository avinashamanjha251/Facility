//
//  HomeHeaderTableCell.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import UIKit

class HomeHeaderTableCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellUI(title: String) {
        lblTitle.text = title
    }
}
