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
    @IBOutlet weak var hutPawIcon:UIImageView?

    
    var parseObject:PFObject?
    
    override func awakeFromNib() {
        
        let gesture = UITapGestureRecognizer(target: self, action:Selector("onDoubleTap:"))
        gesture.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(gesture)
        
        hutPawIcon?.hidden = true
        
        super.awakeFromNib()
  
        // Initialization code
    }

    func onDoubleTap(sender:AnyObject) {
        
        if(parseObject != nil) {
            if var votes:Int? = parseObject!.objectForKey("votes") as? Int {
                votes!++
                
                parseObject!.setObject(votes!, forKey: "votes");
                parseObject!.saveInBackground();
                
                hutVotesLabel?.text = "\(votes!) votes";
            }
        }
        hutPawIcon?.hidden = false
        hutPawIcon?.alpha = 1.0
        
        UIView.animateWithDuration(1.0, delay: 1.0, options:[], animations: {
            
            self.hutPawIcon?.alpha = 0
            
            }, completion: {
                (value:Bool) in
                
                self.hutPawIcon?.hidden = true
        })
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
