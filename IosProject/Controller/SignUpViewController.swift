//
//  SignUpViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/14/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//
import Alamofire
import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    let URL_USER_REGISTER = "http://192.168.64.2/miniprojet/Time/signup.php"
    @IBOutlet weak var signin: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
               let blocus = UIImage(named: "blocus")
               addicontextfield(textField: password, andImage: blocus!)
               let mail = UIImage(named: "@")
               addicontextfield(textField: email, andImage: mail!)
            let user = UIImage(named: "user")
               addicontextfield(textField: username, andImage: user!)
               email.delegate = self
               password.delegate = self
                username.delegate = self
             
              // email.backgroundColor  = UIColor.red;
               email.layer.cornerRadius = 20
               password.layer.cornerRadius = 20
               username.layer.cornerRadius = 20
               signin.layer.borderColor  =  UIColor(white: 1.0, alpha: 0.3).cgColor
               signin.layer.borderWidth = 1.0
               signin.layer.cornerRadius = 40
               
               // Do any additional setup after loading the view.
               
               //listen for keyboard events
               NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillChange(notification:)) , name:  UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillChange(notification:)) , name:  UIResponder.keyboardWillHideNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillChange(notification:)) , name:  UIResponder.keyboardWillChangeFrameNotification, object: nil)
               
           }
           deinit {
                NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillChange(notification:)) , name:  UIResponder.keyboardWillShowNotification, object: nil)
                       NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillChange(notification:)) , name:  UIResponder.keyboardWillHideNotification, object: nil)
                       NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillChange(notification:)) , name:  UIResponder.keyboardWillChangeFrameNotification, object: nil)
                }
           
           
           
           
           @objc func keyboardWillChange(notification: Notification){
               guard let keyboardreact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue  else{
                   return
               }
               if notification.name == UIResponder.keyboardWillShowNotification ||
                   notification.name == UIResponder.keyboardWillChangeFrameNotification {
                   view.frame.origin.y = -keyboardreact.height
               }else{
                   view.frame.origin.y = 0
               }
               
           }
    
           func addicontextfield(textField: UITextField, andImage img:UIImage)
           {
               let leftimage = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
               leftimage.image = img
               textField.leftView = leftimage
            textField.leftViewMode = .always
           }
           
           func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                   username.resignFirstResponder()//delegate method
                   email.resignFirstResponder()
                   //password.resignFirstResponder()
                   
                   return true
                 }
    
                   
    @IBAction func Signup(_ sender: UIButton) {
        
        let parameters: Parameters=["name":username.text!,"email":email.text!,"password":password.text!,]
        let Email = email.text!
        let Password = password.text!
                
        if username.text == "" {
            let alert = UIAlertController(title: "Alert", message: "you need to full all the field", preferredStyle: .alert)
            let Ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(Ok)
            self.present(alert,animated: true,completion: nil)
            
        }else if isValidEmail(emailID: Email) == false{
            
            let alert = UIAlertController(title: "Alert", message: "chek your Email address", preferredStyle: .alert)
            let Ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(Ok)
            self.present(alert,animated: true,completion: nil)
            
        }else if Password.count < 6 {
            
            let alert = UIAlertController(title: "Alert", message: "your password is weak", preferredStyle: .alert)
            let Ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(Ok)
            self.present(alert,animated: true,completion: nil)
            
        }else {
            AF.request(URL_USER_REGISTER, method: .get, parameters: parameters).responseString
                {
                    response in
                    print(response)

                    switch response.result {
                    case .success:
                        
                        let alert = UIAlertController(title: "Alert", message: "User registred ", preferredStyle: .alert)
                        let Ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(Ok)
                        self.present(alert,animated: true,completion: nil)
                        
                        

                    case .failure:
                        
                        let alert = UIAlertController(title: "Alert", message: " User not registred ", preferredStyle: .alert)
                        let Ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(Ok)
                        self.present(alert,animated: true,completion: nil)
                    }
            }
            //dismiss(animated: true, completion: nil)
            //self.performSegue(withIdentifier: "signin", sender: self)
        }
                    
                    
               
    }
    func isValidEmail (emailID:String) -> Bool {
        let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
}
