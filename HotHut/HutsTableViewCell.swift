//
//  HutsTableViewCell.swift
//  HotHut
//
//  Created by Sunny Chiu on 10/15/15.
//  Copyright © 2015 com.ching. All rights reserved.
//

import UIKit

class HutsTableViewCell: PFTableViewCell {
    
    @IBOutlet weak var hutImageView:UIImageView?
    @IBOutlet weak var hutNameLabel:UILabel?
    @IBOutlet weak var hutVotesLabel:UILabel?
    @IBOutlet weak var hutCreditLabel:UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
