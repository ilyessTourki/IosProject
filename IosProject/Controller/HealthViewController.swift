//
//  HealthViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/29/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit
import Alamofire

class HealthViewController: UIViewController {
    
    @IBOutlet weak var Age: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UITextField!
    let HEALTH_INSERT = "http://192.168.64.2/miniprojet/Time/healthinsert.php"
    var userid = (UserDefaults.standard.value(forKey: "id") as! NSString).doubleValue
    @IBOutlet weak var female: UIButton!
    @IBOutlet weak var male: UIButton!
    var gender = ""
    var IMC : Float = 1.2
    var wei : Float = 0
    var hei  : Float = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func retour(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func submit(_ sender: UIButton) {
        
        if male.isSelected{
            gender = "male"
        }
        if female.isSelected {
            gender = "female"
        }
        
        if female.isSelected || male.isSelected && (height.text != "") && (weight.text != "") && (Age.text != ""){
            wei = Float(weight.text!)!
            hei = Float(height.text!)!
            IMC =  wei / (Float(hei / 100) *  Float(hei / 100))

            let parameters: Parameters=["userid":userid,"height":height.text!,"weight":weight.text!,"imc":String(IMC),
                    "sexe":gender,"age":Age.text!,]

                
                AF.request(HEALTH_INSERT, method: .get, parameters: parameters).responseString
                {
                    response in
                    print(response)


                    switch response.result {
                    case .success:
                        print("wey")

                    case .failure(let error):
                    print(error)
                    }
            }
            dismiss(animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Alert", message: "you need to full all the field", preferredStyle: .alert)
            let Ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(Ok)
            self.present(alert,animated: true,completion: nil)
        }
        
    }
   
    @IBAction func hemale(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            female.isSelected = false
        }
        else{
            sender.isSelected = true
             female.isSelected = false
        }
    }
    @IBAction func shefemale(_ sender: UIButton) {
        if sender.isSelected{
                    sender.isSelected = false
                    male.isSelected = false
               }
               else{
                    sender.isSelected = true
                    male.isSelected = false
               }
    }
}
