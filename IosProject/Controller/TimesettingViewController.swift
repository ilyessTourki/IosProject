//
//  TimesettingViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/25/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit

class TimesettingViewController: UIViewController {

    @IBOutlet weak var ms: UIDatePicker!
    @IBOutlet weak var me: UIDatePicker!
    @IBOutlet weak var ts: UIDatePicker!
    @IBOutlet weak var te: UIDatePicker!
    @IBOutlet weak var ws: UIDatePicker!
    @IBOutlet weak var we: UIDatePicker!
    @IBOutlet weak var ths: UIDatePicker!
    @IBOutlet weak var the: UIDatePicker!
    @IBOutlet weak var fs: UIDatePicker!
    @IBOutlet weak var fe: UIDatePicker!
    @IBOutlet weak var ss: UIDatePicker!
    @IBOutlet weak var se: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        //setNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Retour(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
//    func setNavigationBar() {
//        let screenSize: CGRect = UIScreen.main.bounds
//         let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
//         self.view.addSubview(navBar)
//     }

    @IBAction func next(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let MS = dateFormatter.string(from:ms.date)
        let ME = dateFormatter.string(from:me.date)
        let TS = dateFormatter.string(from:ts.date)
        let TE = dateFormatter.string(from:te.date)
        let WS = dateFormatter.string(from:ws.date)
        let WE = dateFormatter.string(from:we.date)
        let THS = dateFormatter.string(from:ths.date)
        let THE = dateFormatter.string(from:the.date)
        let FS = dateFormatter.string(from:fs.date)
        let FE = dateFormatter.string(from:fe.date)
        let SS = dateFormatter.string(from:ss.date)
        let SE = dateFormatter.string(from:se.date)
        let sportsetting = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sportsetting") as! SportSettingViewController;()
        sportsetting.ms = MS
        sportsetting.me = ME
        sportsetting.ts = TS
        sportsetting.te = TE
        sportsetting.ws = WS
        sportsetting.we = WE
        sportsetting.ths = THS
        sportsetting.the = THE
        sportsetting.fs = FS
        sportsetting.fe = FE
        sportsetting.ss = SS
        sportsetting.se = SE
         sportsetting.modalPresentationStyle = .fullScreen
        self.present(sportsetting, animated: true, completion: nil)
       
        
        
    }
}
