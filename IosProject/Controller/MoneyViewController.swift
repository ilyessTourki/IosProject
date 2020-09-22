//
//  MoneyViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/29/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit
import Alamofire

class MoneyViewController: UIViewController {

    @IBOutlet weak var saler: UITextField!
    @IBOutlet weak var dt2: UILabel!
    @IBOutlet weak var much2: UITextField!
    @IBOutlet weak var dt1: UILabel!
    @IBOutlet weak var much1: UITextField!
    @IBOutlet weak var oui: UIButton!
    @IBOutlet weak var ui: UIButton!
    let Money_Insert = "http://192.168.64.2/miniprojet/Time/moneyinsert.php"
    var userid = (UserDefaults.standard.value(forKey: "id") as! NSString).doubleValue
    var salerr = 0
    var rent = 0
    var habit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        much1.isHidden = true
        dt1.isHidden = true
        much2.isHidden = true
        dt2.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Retour(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if(much1.text != ""){
            rent = Int(much1.text!)!
        }
        if(much2.text != ""){
                  habit = Int(much2.text!)!
               }
        
        
        if(saler.text != "") && (Int(saler.text!)! > rent+habit){
            let parameters: Parameters=[
                "userid":userid,
                "saler":saler.text!,
                "rent":rent,
                "habit":habit,
                
            ]
            
            //Sending http post request
            AF.request(Money_Insert, method: .get, parameters: parameters).responseString
                {
                    response in
                    //printing response
                    
                    print(response)
                    
                    
                    switch response.result {
                    case .success:
                        print("wey")
                        
                    case .failure(let error):
                        print(error)
                    }
                    //getting the json value from the server
                    
                    
            }
            salerr = Int(saler.text!)!
            dismiss(animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Alert", message: "saler have to be higher then rent and habit", preferredStyle: .alert)
            let Ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(Ok)
            self.present(alert,animated: true,completion: nil)
        }
        let rest =  salerr - rent - habit
        UserDefaults.standard.set(rest, forKey:"rest")
        
    }
   
    
    @IBAction func oui1(_ sender: UIButton) {
        
          much1.isHidden = false
          dt1.isHidden = false
    
    }
    
    @IBAction func ui1(_ sender: UIButton) {
        
        much2.isHidden = false
        dt2.isHidden = false
        
    }
    
    
}
