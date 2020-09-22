//
//  SportSettingViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/27/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit

class SportSettingViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    
    var ms = ""
    var me = ""
    var ts = ""
    var te = ""
    var ws = ""
    var we = ""
    var ths = ""
    var the = ""
    var fs = ""
    var fe = ""
    var ss = ""
    var se = ""
    var day1 = ""
    var timeo = ""
    var day2 = ""
    var timet = ""
    var day3 = ""
    var timeth = ""
    var day4 = ""
    var timef = ""
    
    @IBOutlet weak var plus2: UIButton!
    @IBOutlet weak var plus1: UIButton!
    @IBOutlet weak var time4: UIDatePicker!
    @IBOutlet weak var time3: UIDatePicker!
    @IBOutlet weak var time2: UIDatePicker!
    @IBOutlet weak var time1: UIDatePicker!
    @IBOutlet weak var days: UIPickerView!
    @IBOutlet weak var days2: UIPickerView!
    @IBOutlet weak var days3: UIPickerView!
    @IBOutlet weak var days4: UIPickerView!
    let day = ["-------","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return day[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return day.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == days)
        {
            if(day[row] != "-------"){
                day1=day[row]
            }
            
        }
        if(pickerView == days2 )
        {
            if(day[row] != "-------"){
                   day2=day[row]
                       }
            
        }
        if(pickerView == days3)
        {
            if(day[row] != "-------"){
            day3=day[row]
                }
            
        }
        if(pickerView == days4)
        {
            if(day[row] != "-------"){
            day4=day[row]
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plus1.isHidden = true
        plus2.isHidden = true
        days2.isHidden = true
        days3.isHidden = true
        days4.isHidden = true
        time2.isHidden = true
        time3.isHidden = true
        time4.isHidden = true
        
        
        

        // Do any additional setup after loading the view.
    }
    @IBAction func retour(_ sender: UIBarButtonItem) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func adddate(_ sender: UIButton) {
        plus1.isHidden = false
        days2.isHidden = false
        time2.isHidden = false
    }
    
    @IBAction func adddate2(_ sender: UIButton) {
        plus2.isHidden = false
        days3.isHidden = false
        time3.isHidden = false
    }
    
    @IBAction func adddate3(_ sender: UIButton) {
        
        days4.isHidden = false
        time4.isHidden = false
    }
    @IBAction func previous(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func next(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let tim1 = dateFormatter.string(from:time1.date)
        let tim2 = dateFormatter.string(from:time2.date)
        let tim3 = dateFormatter.string(from:time3.date)
        let tim4 = dateFormatter.string(from:time4.date)
        let sportsetting = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "asso") as! AssoViewController
        sportsetting.ms = ms
        sportsetting.me = me
        sportsetting.ts = ts
        sportsetting.te = te
        sportsetting.ws = ws
        sportsetting.we = we
        sportsetting.ths = ths
        sportsetting.the = the
        sportsetting.fs = fs
        sportsetting.fe = fe
        sportsetting.ss = ss
        sportsetting.se = se
        sportsetting.day1 = day1
        sportsetting.time1 = tim1
        sportsetting.day2 = day2
        sportsetting.time2 = tim2
        sportsetting.day3 = day3
        sportsetting.time3 = tim3
        sportsetting.day4 = day4
        sportsetting.time4 = tim4
        
         sportsetting.modalPresentationStyle = .fullScreen
        self.present(sportsetting, animated: true, completion: nil)
        
    }
}
