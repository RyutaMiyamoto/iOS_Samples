//
//  CustomCell.swift
//  UITableViewAccordionSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    
    func flexibleCell() {
        cellHeight.constant = cellHeight.constant == 44 ? 100 : 44
    }
}
