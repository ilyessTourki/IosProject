//
//  ListeChallengesViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 5/1/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//
import Alamofire
import UIKit

class ListeChallengesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var charging: UIActivityIndicatorView!
    let GETCAHLLENGE = "http://192.168.64.2/miniprojet/Time/affichechallenge.php"
    let COUNT = "http://192.168.64.2/miniprojet/Time/count.php"
    @IBOutlet weak var tableview: UITableView!
    let dispatchgrou = DispatchGroup()
    let calendar = NSDate() as Date
    var type = ""
    var eltype = 0
    // @IBOutlet weak var add: UIButton!
    
    var challenges : [Chalenge] = []
    var chall : [Chalenge] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        tableview.delegate = self
        tableview.dataSource =  self
        tableview.rowHeight = 120
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
            self.tableview.reloadData()
        }
        
        
        
        
    }
    
    func run(after seconds:Int,completion:@escaping () -> Void){
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            completion()
        }
    }
    
    func createArray() {
        
        
        
        dispatchgrou.enter()
        if (self.type ==  "time"){
            eltype = 1
        }
        if (self.type ==  "money"){
            eltype = 2
        }
        if (self.type ==  "health"){
            eltype = 3
        }
        let parameters: Parameters=[
            "type":eltype,
        ]
        
        
        AF.request(GETCAHLLENGE, method: .get, parameters: parameters).responseJSON
            {
                response in
                //printing response
                let jsonData = response.value as! NSArray
                switch response.result {
                case .success(let value):
                    AF.request(self.COUNT, method: .get,parameters: parameters).responseJSON
                        {
                            response in
                            //printing response
                            let jsonDa = response.value as! NSDictionary
                            let resp = jsonDa.value(forKey:"response")
                            print(resp as Any)
                            switch response.result {
                            case .success(let value):
                                print("Oh")
                                let i = (resp as! NSString).doubleValue
                                print(i)
                                var j = 0
                                while (j < Int(i))  {
                                    let id =  jsonData.value(forKey: "id") as! Array<Any>
                                    let titr =  jsonData.value(forKey: "titre") as! Array<Any>
                                    let datt =  jsonData.value(forKey:   "datefin")
                                        as! Array<Any>
                                    let desc =  jsonData.value(forKey:   "description")
                                        as! Array<Any>
                                    if (titr != nil){
                                        let chall1 = Chalenge(
                                            id: id[j] as! String
                                            ,titre: titr[j] as! String
                                            ,date: datt[j] as! String
                                            , description:  desc[j] as! String )
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
                                    
                                    j += 1
                                    
                                }
                            case .failure(let error):
                                print(error)
                            }
                    }
                    
                case .failure(let error):
                    print(error)
                }
        }
        
        dispatchgrou.leave()
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
        self.present(sportsetting, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func retour(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 48))
        
        self.view.addSubview(navBar)
    }
    
    
    @IBAction func addc(_ sender: UIButton) {
        // print("ok")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addchallenge = segue.destination as? AddchallengeViewController {
            addchallenge.callback = { message in
                if message == "X"{
                    self.showToast(message: "Chellenge Added")
                }
                
                
            }
        }
    }
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        // toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    
}
