//
//  ClassementViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 6/24/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit
import Alamofire

class ClassementViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var charge: UIActivityIndicatorView!
    let GetRanks = "http://192.168.64.2/miniprojet/Time/topscore.php"
    var username = UserDefaults.standard.value(forKey: "name") as! String
    var users : [User] = []
    var user : [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableview.delegate = self
        tableview.dataSource =  self
        tableview.rowHeight = 120
        createArray()
        charge.startAnimating()
        charge.center = view.center
        charge.color = UIColor.red
        run(after: 1){
            
            self.users = self.user
            print(self.username)
        }
        run(after: 2){
            self.charge.isHidden = true
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
        
        AF.request(GetRanks, method: .get).responseJSON
            {
                response in
                switch response.result {
                case .success:
                   let jsonData = response.value as! NSArray
                   let PointUser = jsonData.value(forKey:"response") as! NSArray
                   let IdUser = jsonData.value(forKey:"id") as! NSArray
                   let NameUser = jsonData.value(forKey:"name") as! NSArray
                   let i = IdUser.count - 1
                   var j = 0
                   while (j <= i )  {
                    let user1 = User(
                    id: IdUser[j] as! String
                    ,name: NameUser[j] as! String
                    ,point: PointUser[j] as! String )
                     self.user.append(user1)
                     j += 1
                    
                    }
                   
                case .failure(let error):
                    print(error)
                }
        }
  
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userr =  users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Rank") as! RankTableViewCell
        
        cell.setRanks(user: userr)
        if(indexPath.row == 0){
            cell.medal.image = UIImage(named: "first")
        }
        else if(indexPath.row == 1){
            cell.medal.image = UIImage(named: "second")
        }
        else if(indexPath.row == 2){
            cell.medal.image = UIImage(named: "third")
        }
         if(userr.name == username )
        {
             cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                                }
        else{
            cell.backgroundColor = .white
                    }
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Rank")
    }
    
}
