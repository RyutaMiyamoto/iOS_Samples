//
//  CustomCell.swift
//  DelegateSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit

protocol CustomCellDelegate: class {
    func tapCellButton(from cell: CustomCell)
}

class CustomCell: UITableViewCell {
    
    weak var delegate: CustomCellDelegate?
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func tapButton(_ sender: UIButton) {
        delegate?.tapCellButton(from: self)
    }
}
