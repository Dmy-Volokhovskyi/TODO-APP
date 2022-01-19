//
//  CategoryTableViewCell.swift
//  TODO APP
//
//  Created by Дмитро Волоховський on 13/01/2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryTitle : UILabel!
    @IBOutlet weak var categoryImage : UIImageView!
    @IBOutlet weak var colorImage : UIImageView!
    
    var cellIndex : Int = 1 
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
