//
//  AssoViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/27/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//
import Alamofire
import UIKit

class AssoViewController: UIViewController {
    let Time_REGISTER = "http://192.168.64.2/miniprojet/Time/timeinsert.php"
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
    var time1 = ""
    var day2 = ""
    var time2 = ""
    var day3 = ""
    var time3 = ""
    var day4 = ""
    var time4 = ""
    var test = 1 ;
    var sport = "0"
    var association = "0"
    var mss = ""
    var mes = ""
    var tss = ""
    var tes = ""
    var wss = ""
    var wes = ""
    var thss = ""
    var userid = (UserDefaults.standard.value(forKey: "id") as! NSString).doubleValue
    
    @IBOutlet weak var when: UILabel!
    @IBOutlet weak var date: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        when.isHidden = true
        date.isHidden = true
        print(time1)
        
        
    }
    

    @IBAction func retour(_ sender: UIBarButtonItem) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func yes(_ sender: UIButton) {
        when.isHidden = false
        date.isHidden = false
        self.test =  2
    }
    
    @IBAction func no(_ sender: UIButton) {
        
        
    }
    @IBAction func previous(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func subbmit(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let asso = dateFormatter.string(from:date.date)
        print(ms)
        if(self.test == 2){
            association = "1"
            print(asso)
            
        }
        if(day1 != " "){
            sport = "1"
        }
        if(day1 == "Monday"){
            mss = day1 + time1
        }
        if(day1 == "Tuesday"){
            mes = day1 + time1
        }
        if(day1 == "Wednesday"){
            tss = day1 + time1
        }
        if(day1 == "Thursday"){
            tes = day1 + time1
        }
        if(day1 == "Friday"){
            wss = day1 + time1
        }
        if(day1 == "Saturday"){
            wes = day1 + time1
        }
        if(day1 == "Sunday"){
            thss = day1 + time1
        }
        
        ////////////
        if(day2 == "Monday"){
            mss = day2 + time2
        }
        if(day1 == "Tuesday"){
            mes = day2 + time2
        }
        if(day1 == "Wednesday"){
            tss = day2 + time2
        }
        if(day1 == "Thursday"){
            tes = day2 + time2
        }
        if(day1 == "Friday"){
            wss = day2 + time2
        }
        if(day1 == "Saturday"){
            wes = day2 + time2
        }
        if(day1 == "Sunday"){
            thss = day2 + time2
        }
        ///////////
        if(day3 == "Monday"){
            mss = day3 + time3
        }
        if(day1 == "Tuesday"){
            mes = day3 + time3
        }
        if(day1 == "Wednesday"){
            tss = day3 + time3
        }
        if(day1 == "Thursday"){
            tes = day3 + time3
        }
        if(day1 == "Friday"){
            wss = day3 + time3
        }
        if(day1 == "Saturday"){
            wes = day3 + time3
        }
        if(day1 == "Sunday"){
            thss = day3 + time3
        }
        ////////
        if(day4 == "Monday"){
            mss = day4 + time4
        }
        if(day1 == "Tuesday"){
            mes = day4 + time4
        }
        if(day1 == "Wednesday"){
            tss = day4 + time4
        }
        if(day1 == "Thursday"){
            tes = day4 + time4
        }
        if(day1 == "Friday"){
            wss = day4 + time4
        }
        if(day1 == "Saturday"){
            wes = day4 + time4
        }
        if(day1 == "Sunday"){
            thss = day4 + time4
        }
        
           let parameter: Parameters=[
                            "mts":ms,
                            "mte":me,
                            "tts":ts,"tte":te,
                            "wts":ws,"wte":we,
                            "fts":fs,"fte":fe,
                            "thts":ths,"thte":the,
                            "sts":ss,"ste":se,
                            "sport":sport,
                            "mss":mss,"mse":" ",
                            "tss":mes,"tse":" ",
                            "wss":tss,"wse":" ",
                            "fss":tes,"fse":" ",
                            "tuss":wss,"tuse":" ",
                            "sss":wes,"sse":" ",
                            "suss":thss,"suse":" ",
                            "asso":association,
                            "dateasso":asso,
                            "userid":userid
                            

                        ]

                        //Sending http post request
                        AF.request(Time_REGISTER, method: .get, parameters: parameter).responseString
                        {
                            response in
                            //printing response

                            print(response)


                            switch response.result {
                            case .success(let value):
                                print("Success")
                                
                                let alert = UIAlertController(title: "Alert", message: "User registred ", preferredStyle: .alert)
                                let Ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alert.addAction(Ok)
                                self.present(alert,animated: true,completion: nil)

            //               let jsonData = value as! NSDictionary
            //               self.mibouna.text = jsonData.value(forKey: "message") as! String?
                            case .failure(let error):
                            print(error)
                            }
                            //getting the json value from the server


                    }
        }
        
    }
    
    

