//
//  SaveMoneyViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 6/24/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit

class SaveMoneyViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var havetoown: UILabel!
    @IBOutlet weak var own: UILabel!
    var day = 0
    var costa = ""
    var rest = (UserDefaults.standard.value(forKey: "rest") as! NSNumber)
    var jour :Float = 0
    var jourrest :Float = 0
    override func viewDidLoad() {
        super.viewDidLoad()

      
        jour = Float(costa)! / Float(day)
        jourrest = Float(rest) / Float(day)
        own.text = String(jourrest.rounded())+" DT"
        havetoown.text = String(jour.rounded())+" DT"
        if(jourrest>=jour)
        {
            message.text = "We count on you to do the necessary"
        }
        else
        {
            message.text = "Unfortunately you cannot save The necessary Money"
            message.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
        
    }
    

    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
