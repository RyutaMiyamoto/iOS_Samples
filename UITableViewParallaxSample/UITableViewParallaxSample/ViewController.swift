//
//  ViewController.swift
//  UITableViewParallaxSample
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
    
    private let dataSource: [String] = ["", "", "", "", "", "", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadDataAfter {
            self.parallax()
        }
    }
    
    private func parallax() {
        guard let tableViewRows = tableView.indexPathsForVisibleRows else { return }
        for indexPath in tableViewRows {
            guard let cell = tableView.cellForRow(at: indexPath) as? CustomCell else { continue }
            let rect = tableView.rectForRow(at:indexPath)
            let rectInTable = tableView.convert(rect, to: tableView.superview)
            let offset = rectInTable.origin.y + rectInTable.height / 2
            let offsetRatio = offset / tableView.bounds.height
            var imageViewRect = cell.parallaxImageView.frame
            imageViewRect.origin.y = offsetRatio * 100 * -1
            cell.parallaxImageView.frame = imageViewRect
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else { return UITableViewCell() }
        return cell
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        parallax()
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
