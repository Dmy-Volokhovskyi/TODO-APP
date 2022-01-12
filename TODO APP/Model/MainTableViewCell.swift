//
//  MainTableViewCell.swift
//  TODO APP
//
//  Created by Дмитро Волоховський on 12/01/2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var date : UILabel!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var done : UILabel!
    @IBOutlet weak var category : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
