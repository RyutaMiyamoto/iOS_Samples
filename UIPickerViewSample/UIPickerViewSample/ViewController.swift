//
//  ViewController.swift
//  UIPickerViewSample
//
//  Created by RyutaMiyamoto on 2018/06/22.
//  Copyright © 2018 RyutaMiyamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var dataSource = ["item1", "item2", "item3", "item4", "item5", "item6", "item7"]
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func changedDatePicker(_ sender: UIDatePicker) {
        print(sender.date)
    }
    
    @IBAction func tapNowButton(_ sender: UIButton) {
        datePicker.date = Date()
    }
    
    @IBAction func tapBeforeButton(_ sender: UIButton) {
        datePicker.date = Date(timeInterval: -(60 * 5), since: datePicker.date)
    }
    
    @IBAction func tapAfterButton(_ sender: UIButton) {
        datePicker.date = Date(timeInterval: 60 * 5, since: datePicker.date)
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(dataSource[row])
    }
}
