//
//  TestViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/21/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//
import Alamofire
import UIKit
import SafariServices

class TestViewController: UIViewController {
  
    @IBOutlet weak var poimts: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var neme: UILabel!
    let useremail = UserDefaults.standard.value(forKey: "email")
    let EMAIL = "http://192.168.64.2/miniprojet/Time/useremail.php"
    override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     self.view.layoutIfNeeded()
     self.setNavigationBar()
     user()
          
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      self.setNavigationBar()
      user()
         
    }
    

    func user(){
        let parameters: Parameters=[
                        "email":useremail!,
                    ]

                    //Sending http post request
        AF.request(EMAIL, method: .get, parameters: parameters).responseJSON
                    {
                        response in
                        //printing response
                        print(response)
                        let jsonDa = response.value as! NSDictionary


                        switch response.result {
                        case .success:
                            print("wey")
                            let name = jsonDa.value(forKey: "name") as! String?
                            let point = jsonDa.value(forKey: "point") as! String?
                            self.email.text = self.useremail as? String
                            self.neme.text = name
                            self.poimts.text = point
                           
                        case .failure(let error):
                        print(error)
                        }
                        //getting the json value from the server


                }
    }
    
    
    
    @IBAction func menuclicked(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
                  }

             
    @IBAction func profmodiff(_ sender: UIButton) {
        let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profmodif") as! ModificationProfileViewController;()
       // popup.modalPresentationStyle = .fullScreen
        popup.nom = self.neme.text ?? ""
        popup.mail = self.email.text ?? ""
       self.present(popup, animated: true, completion: nil)
       
        
    }
    func setNavigationBar() {
       let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 10))
       
   /* let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)*/
        self.view.addSubview(navBar)
    }
   
    @IBAction func timesetting(_ sender: UIButton) {
        
        
        let timesetting = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "timesetting") as! TimesettingViewController;()
               timesetting.modalPresentationStyle = .fullScreen
              self.present(timesetting, animated: true, completion: nil)
        
    }
    
    @IBAction func MoneySetting(_ sender: UIButton) {
        let timesetting = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "money") as! MoneyViewController;()
                      timesetting.modalPresentationStyle = .fullScreen
                     self.present(timesetting, animated: true, completion: nil)
    }
    @IBAction func Healthsetting(_ sender: UIButton) {
        let timesetting = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "health") as! HealthViewController;()
                             timesetting.modalPresentationStyle = .fullScreen
                            self.present(timesetting, animated: true, completion: nil)
    }
}

