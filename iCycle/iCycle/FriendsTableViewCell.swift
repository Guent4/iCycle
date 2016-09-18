//
//  FriendsTableViewCell.swift
//  iCycle
//
//  Created by Gautham Sezhian on 9/17/16.
//  Copyright © 2016 GSR. All rights reserved.
//

import Foundation
import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendScore: UILabel!
    @IBOutlet weak var friendPosition: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}