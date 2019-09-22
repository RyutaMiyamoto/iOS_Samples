//
//  CustomCell.swift
//  DelegateSample
//
//  Created by R.miyamoto on 2019/09/16.
//  Copyright © 2019 R.Miyamoto. All rights reserved.
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
