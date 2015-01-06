//
//  CustomCell.swift
//  weatherReport
//
//  Created by Tatsuya Yokoyama on 2015/01/06.
//  Copyright (c) 2015年 yokoyama.tatsuya. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    

    @IBOutlet weak var mainLabel: UILabel!

    @IBOutlet weak var subLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
