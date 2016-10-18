//
//  RedDoctoresTableViewCell.swift
//  zungu
//
//  Created by Giovanni Aranda on 26/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class RedDoctoresTableViewCell: UITableViewCell {

    @IBOutlet weak var imagenRed: UIImageView!
    @IBOutlet weak var nombreRed: UILabel!
    @IBOutlet weak var correoRed: UILabel!
    @IBOutlet weak var telefonoRed: UILabel!
    @IBOutlet weak var seguidoresRed: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
