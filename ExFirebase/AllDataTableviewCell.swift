//
//  AllDataTableviewCell.swift
//  ExFirebase
//
//  Created by RLogixxTraining on 30/05/24.
//

import UIKit

class AllDataTableviewCell: UITableViewCell {

    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
