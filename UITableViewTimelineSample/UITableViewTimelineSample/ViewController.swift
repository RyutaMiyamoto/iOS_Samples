//
//  ViewController.swift
//  UITableViewTimelineSample
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
    
    private var heightAtIndexPath: Dictionary<IndexPath, CGFloat> = [:]
    
    private var dataSource: Array<(Bool, String)> = []
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        let num = arc4random() % 100 + 1
        var cnt = 0
        var text = ""
        let isMe = arc4random_uniform(2) == 0
        while cnt <= num {
            text = text + dataSource.count.description
            cnt = cnt + 1
        }
        dataSource.append((isMe, text))
        tableView.reloadDataAfter {
            self.tableView.scrollToRow(at: IndexPath(row: self.dataSource.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height: CGFloat = heightAtIndexPath[indexPath] {
            return height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        heightAtIndexPath[indexPath] = cell.frame.height
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else { return UITableViewCell() }
        cell.talk(isMe: dataSource[indexPath.row].0, text: dataSource[indexPath.row].1)
        return cell
    }
}

extension UITableView {
    func reloadDataAfter(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { _ in
            completion()
        }
    }
}
