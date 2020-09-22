//
//  GiftingViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 6/24/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit

class GiftingViewController: UIViewController {

    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var Dategift: UIDatePicker!
    //var dateString = ""
    var dateString = NSDate() as Date
    var calendar = NSDate() as Date
    override func viewDidLoad() {
        super.viewDidLoad()

        
         
        
    }
               


    @IBAction func save(_ sender: UIButton) {
        dateString = Dategift.date
        print(dateString)
        let calendarr = Calendar.current
        let date1 = calendarr.startOfDay(for: dateString)
        print(date1)
        let date2 = calendarr.startOfDay(for: self.calendar)
        print(date2)
        let components = calendarr.dateComponents([.day], from: date2, to: date1)
        let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "savemoney") as! SaveMoneyViewController
        popup.day = components.day!
        popup.costa = cost.text!
        self.present(popup, animated: true, completion: nil)
        
        
    }
    

}
