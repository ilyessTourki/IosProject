//
//  ModificationProfileViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/25/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit
import Alamofire
class ModificationProfileViewController: UIViewController {
    let MODIFUSER = "http://192.168.64.2/miniprojet/Time/usermodif.php"
    var nom = ""
    var mail = ""
    var mailuser = UserDefaults.standard.value(forKey: "email")
    var passuser = UserDefaults.standard.value(forKey: "password")
    @IBOutlet weak var namefield: UITextField!
    @IBOutlet weak var emailfield: UITextField!
    @IBOutlet weak var oldfield: UITextField!
    @IBOutlet weak var newfield: UITextField!
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var labelforcureentpass: UILabel!
    @IBOutlet weak var labelforconfirmpassword: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        namefield.text = nom
        emailfield.text = mail
    }
    
     func checkpassword() -> Bool{
        if (oldfield.text ==  passuser as? String){
            return true
        }
        else{ return false}
    }

    @IBAction func closepopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmModif(_ sender: UIButton) {
        if(!checkpassword()){
            labelforcureentpass.text = "incorrect password"
        }
        else {
            labelforcureentpass.text = ""
        }
        if(newfield.text != confirm.text){
            labelforconfirmpassword.text = "passwords don't match"
        }
        else {
             labelforconfirmpassword.text = ""
        }
        if(checkpassword() && (newfield.text == confirm.text)){
            let parameters: Parameters=[
                            "name":namefield.text!,
                            "email":emailfield.text!,
                            "password":newfield.text!,

                        ]

                        //Sending http post request
                        AF.request(MODIFUSER, method: .get, parameters: parameters).responseString
                        {
                            response in
                            //printing response

                            print(response)


                            switch response.result {
                            case .success:
                                let alert = UIAlertController(title: "Alert", message: "User Modified", preferredStyle: .alert)
                                let Ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alert.addAction(Ok)
                                self.present(alert,animated: true,completion: nil)
                                //self.dismiss(animated: true, completion: nil)
                                
                            case .failure(let error):
                            print(error)
                            }
                            //getting the json value from the server


                    }
        }
    }
    
}
