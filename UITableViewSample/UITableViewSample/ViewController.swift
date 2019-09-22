//
//  ViewController.swift
//  UITableViewSample
//
//  Created by RyutaMiyamoto on 2019/09/22.
//  Copyright © 2019 RyutaMiyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        }
    }
    
    private let dataSource: [UIColor] = [.red, .green, .blue, .cyan, .yellow, .magenta]
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        cell.backgroundColor = dataSource[indexPath.row]
        return cell
    }
}

