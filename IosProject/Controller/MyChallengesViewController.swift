//
//  MyChallengesViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/24/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit
import Alamofire

class MyChallengesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var charging: UIActivityIndicatorView!
    @IBOutlet weak var tabview: UITableView!
    let GETCAHLLENGE = "http://192.168.64.2/miniprojet/Time/cahlliduser.php"
    let ChallUser = "http://192.168.64.2/miniprojet/Time/affichechallengeuser.php"
    var userid = (UserDefaults.standard.value(forKey: "id") as! NSString).doubleValue
    let calendar = NSDate() as Date
    var type = ""
    var eltype = 0
    var challenges : [Chalenge] = []
    var chall : [Chalenge] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tabview.delegate = self
        tabview.dataSource =  self
        tabview.rowHeight = 120
        self.setNavigationBar()
        createArray()
        charging.startAnimating()
        charging.center = view.center
        charging.color = UIColor.red
        run(after: 1){
            
            self.challenges = self.chall
            print(self.challenges)
        }
        run(after: 2){
            self.charging.isHidden = true
            self.tabview.reloadData()
        }
        
        
        
        
    }
    
    func run(after seconds:Int,completion:@escaping () -> Void){
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            completion()
        }
    }
    
    func createArray() {
        
        
        let parameters: Parameters=[
            "userid":userid,
        ]
        
        
        AF.request(GETCAHLLENGE, method: .get, parameters: parameters).responseJSON
            {
                response in
                //printing response
                
    
                
                switch response.result {
                case .success(let value):
                    //if(response)
                    if((response.value as? NSArray) != nil)
                    {
                    
                    let jsonData = response.value as! NSArray
                    let idchall = jsonData.value(forKey:"response") as! NSArray
                        print(idchall[0])
                    let i = idchall.count - 1
                    var j = 0
                    while (j <= i )  {
                        print(idchall[j])
                        
                    let param: Parameters=[
                               "id":idchall[j],
                           ]
                    
                    
                    AF.request(self.ChallUser, method: .get,parameters: param).responseJSON
                        {
                            response in
                            //printing response
                            let jsonDa = response.value as! NSDictionary
                            let resp = jsonDa.value(forKey:"response")
                            print(resp as Any)
                            switch response.result {
                            case .success(let value):
                                
//                                let i = (resp as! NSString).doubleValue
//                                print(i)
//                                var j = 0
//                                while (j < Int(i))  {
                                    let id =  jsonDa.value(forKey: "id")
                                    let titr =  jsonDa.value(forKey: "titre")
                                    let datt =  jsonDa.value(forKey:   "datefin")
                                    let desc =  jsonDa.value(forKey:   "description")
                                    if (titr != nil){
                                        let chall1 = Chalenge(
                                            id: id as! String
                                            ,titre: titr as! String
                                            ,date: datt as! String
                                            , description:  desc as! String )
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy-MM-dd"
                                        //let dateString = dateFormatter.string(from: self.calendar as Date )
                                        let dat = dateFormatter.date(from:chall1.date)!
                                        let calendarr = Calendar.current
                                        let date1 = calendarr.startOfDay(for: dat)
                                        let date2 = calendarr.startOfDay(for: self.calendar)
                                        let components = calendarr.dateComponents([.day], from: date2, to: date1)
                                        if(components.day ?? 0 >= 0)   {
                                            self.chall.append(chall1)
                                        }
                                    

                                }
                            
                            case .failure(let error):
                                print(error)
                            }
                    }
                    j += 1
                    }
                        }
                        else{
                           let alert = UIAlertController(title: "Error", message: "You do not participate to any challenge  ", preferredStyle: .alert)
                            let Ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                            alert.addAction(Ok)
                            self.present(alert,animated: true,completion: nil)
                        }
                case .failure(let error):
                    print(error)
                }
        }
        
        print("hello")
   
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let challeng =  challenges[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "challengecell") as! challengeViewCell
        
        cell.setChallenge(challenge: challeng)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challeng =  challenges[indexPath.row]
        
        let sportsetting = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detail") as! DetailsViewController;()
        sportsetting.modalPresentationStyle = .fullScreen
        sportsetting.id = challeng.id
        sportsetting.tit = challeng.titre
        sportsetting.date = challeng.date
        sportsetting.desc = challeng.description
        sportsetting.mychallecge = "my"
        self.present(sportsetting, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func retourmenu(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        
        self.view.addSubview(navBar)
    }
}
