//
//  DetailsViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 5/3/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var particpation: UIButton!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet var descr: UITextView!
    @IBOutlet weak var Dater: UILabel!
    let calendar = NSDate() as Date
    var id = ""
    var tit = ""
    var desc = ""
    var date = ""
    var mychallecge = ""
    let PARTICIPATE = "http://192.168.64.2/miniprojet/Time/updateuser.php"
    var userid = (UserDefaults.standard.value(forKey: "id") as! NSString).doubleValue
    override func viewDidLoad() {
        super.viewDidLoad()
        if (mychallecge=="my"){
            particpation.isHidden = true
        }
        setNavigationBar()
        
        print(calendar)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: calendar as Date)
        let dat = dateFormatter.date(from:date)!
        let calendarr = Calendar.current
        let date1 = calendarr.startOfDay(for: dat)
        let date2 = calendarr.startOfDay(for: calendar)
        let components = calendarr.dateComponents([.day], from: date2, to: date1)
        titre.text = tit
        Dater.text = date
        descr.text = desc
    }
    

    func setNavigationBar() {
             let screenSize: CGRect = UIScreen.main.bounds
              let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 48))
              self.view.addSubview(navBar)
          }

    @IBAction func Retour(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    @IBAction func participate(_ sender: UIButton) {
        let parameters: Parameters=[
                   
                   "userid":userid,
                   "challid":id,
                   
               ]
               AF.request(self.PARTICIPATE, method: .get,parameters: parameters).responseJSON
                   {
                       response in
                       //printing response
                       let jsonData = response.value as! NSDictionary
                       let resp = jsonData.value(forKey:"response")
                    let responser = jsonData.value(forKey:"resp") as! String
                      print(response)
                       
                       
                       switch response.result {
                       case .success:
                        if responser == "error" {
                            let alert = UIAlertController(title: "Error", message: "You already Participating to this challenge ", preferredStyle: .alert)
                            let Ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                            alert.addAction(Ok)
                            self.present(alert,animated: true,completion: nil)
                            
                        }
                        else{
                            let alert = UIAlertController(title: "Done", message: "Your Particicpation Has Been Saved ", preferredStyle: .alert)
                            let Ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(Ok)
                            self.present(alert,animated: true,completion: nil)
                                             
                        }
                          
                           
                       case .failure(let error):
                           print(error)
                           print("not ok")
                       }
               }
    }
}
