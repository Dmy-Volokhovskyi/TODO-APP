//
//  CategoryTableViewCell.swift
//  TODO APP
//
//  Created by Дмитро Волоховський on 13/01/2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryTitle : UILabel!
    @IBOutlet weak var emojiLabel : UILabel!
    @IBOutlet weak var colorImage : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
