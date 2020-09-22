//
//  MoneyHomeViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 6/23/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit
import Alamofire

class MoneyHomeViewController: UIViewController {

    @IBOutlet weak var firstlab: UILabel!
    @IBOutlet weak var save: UILabel!
    @IBOutlet weak var charge: UIActivityIndicatorView!
    @IBOutlet weak var thismonth: UILabel!
    @IBOutlet weak var youcan: UILabel!
    @IBOutlet weak var simple: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    var userid = (UserDefaults.standard.value(forKey: "id") as! NSString).doubleValue
    let Money_Affiche = "http://192.168.64.2/miniprojet/Time/moneytest.php"
    var saler = ""
    var rent = ""
    var habit = ""
    var saving = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        
              button1.isHidden = true
              button2.isHidden = true
              button3.isHidden = true
              button4.isHidden = true
              button5.isHidden = true
              button6.isHidden = true
              button7.isHidden = true
              button8.isHidden = true
              button9.isHidden = true
              button10.isHidden = true
              charge.isHidden = true
              thismonth.isHidden = true
              youcan.isHidden = true
              simple.isHidden = true
              firstlab.isHidden = true
              consommation()
          
       }
       
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    func run(after seconds:Int,completion:@escaping () -> Void){
                let deadline = DispatchTime.now() + .seconds(seconds)
                DispatchQueue.main.asyncAfter(deadline: deadline){
                    completion()
                }
            }

    func consommation(){
        let parameter: Parameters=[
                      "userid":userid
                  ]
                  
                  //Sending http post request
                  AF.request(Money_Affiche, method: .get, parameters: parameter).responseJSON
                      {
                          response in
                          //printing response
                       
                          let jsonData = response.value as! NSDictionary
                          
                          
                          print(response)
                          
                          
                          switch response.result {
                          case .success:
                              print("Success")
                              
                              if nil != jsonData.value(forKey: "rent"){
                                self.rent = jsonData.value(forKey:"rent") as! String
                                self.habit = jsonData.value(forKey:"habit") as! String
                                self.saler = jsonData.value(forKey:"saler") as! String
                                
                                self.button1.isHidden = false
                                self.button2.isHidden = false
                                self.button3.isHidden = false
                                self.button4.isHidden = false
                                self.button5.isHidden = false
                                self.button6.isHidden = false
                                self.button7.isHidden = false
                                self.button8.isHidden = false
                                self.button9.isHidden = false
                                self.button10.isHidden = false
                                self.charge.isHidden = false
                                self.thismonth.isHidden = false
                                self.youcan.isHidden = false
                                self.simple.isHidden = false
                                
                                self.charge.startAnimating()
                                self.run(after: 1){
                                    self.saving =  Int(self.saler)! - Int(self.habit)! - Int(self.rent)!
                                    print(self.saving)
                                    self.charge.isHidden = true
                                    self.save.text =  String(self.saving) + " DT"
                                    }
                              }else{
                                  self.firstlab.isHidden = false
                              }
                                 
                          case .failure(let error):
                              print(error)
                          }
                          //getting the json value from the server
                          
                          
                  }
    }
    func taillebutton(bout1 :UIButton,bout2 :UIButton,bout3 :UIButton,bout4 :UIButton,bout5 :UIButton,bout6 :UIButton,bout7 :UIButton,bout8 :UIButton,bout9 :UIButton,bout10 :UIButton)
    {
        bout1.frame.size = CGSize(width: 120, height: 41)
        bout1.tintColor = UIColor.red
        bout2.frame.size = CGSize(width: 80, height: 41)
        bout3.frame.size = CGSize(width: 80, height: 41)
        bout4.frame.size = CGSize(width: 80, height: 41)
        bout5.frame.size = CGSize(width: 80, height: 41)
        bout6.frame.size = CGSize(width: 80, height: 41)
        bout7.frame.size = CGSize(width: 80, height: 41)
        bout8.frame.size = CGSize(width: 80, height: 41)
        bout9.frame.size = CGSize(width: 80, height: 41)
        bout10.frame.size = CGSize(width: 80, height: 41)
        bout10.tintColor = UIColor.black
        bout2.tintColor = UIColor.black
        bout3.tintColor = UIColor.black
        bout4.tintColor = UIColor.black
        bout5.tintColor = UIColor.black
        bout6.tintColor = UIColor.black
        bout7.tintColor = UIColor.black
        bout8.tintColor = UIColor.black
        bout9.tintColor = UIColor.black
    }
    
    @IBAction func but1(_ sender: UIButton) {
        taillebutton(bout1: button1, bout2: button2, bout3: button3, bout4: button4, bout5: button5, bout6: button6, bout7: button7, bout8: button8, bout9: button9, bout10: button10)
        titre.text = "Have a Budget"
        desc.text = "Many people don’t budget because they don’t want to go through what they think will be a boring process of listing out expenses, adding up numbers, and making sure everything lines up. If you’re bad with money, you don’t have room for excuses with budgeting. If all it takes to get your spending on track is a few hours working a budget each month, why wouldn’t you do it? Instead of focusing on the process of creating a budget, focus on the value that budgeting will bring to your life."
    }
    
    @IBAction func but2(_ sender: UIButton) {
        taillebutton(bout1: button2, bout2: button1, bout3: button3, bout4: button4, bout5: button5, bout6: button6, bout7: button7, bout8: button8, bout9: button9, bout10: button10)
        titre.text = "Using the Budget"
               desc.text = "Your budget is useless if you make it then let it collect dust in a folder tucked away in your bookshelf or file cabinet. Refer to it often throughout the month to help guide your spending decisions. Update it as you pay bills and spend on other monthly expenses. At any given time during the month, you should have an idea of how much money you’re able to spend, considering any expenses you have left to pay."
    }
    
    @IBAction func but3(_ sender: UIButton) {
         taillebutton(bout1: button3, bout2: button1, bout3: button2, bout4: button4, bout5: button5, bout6: button6, bout7: button7, bout8: button8, bout9: button9, bout10: button10)
        titre.text = "Limit For Spending"
        desc.text = "A critical part of your budget is the net income or the amount of money left after you subtract your expenses from your income. If you have any money left over, you can use it for fun and entertainment, but only up to a certain amount. You can’t go crazy with this money, especially if it’s not a lot and it has to last the entire month. Before you make any big purchases, make sure it won’t interfere with anything else you have planned."
    }
    
    @IBAction func but4(_ sender: UIButton) {
        taillebutton(bout1: button4, bout2: button1, bout3: button3, bout4: button2, bout5: button5, bout6: button6, bout7: button7, bout8: button8, bout9: button9, bout10: button10)
        titre.text = "Track Your Spending"
        desc.text = "Small purchases here and there add up quickly, and before you know it, you’ve overspent your budget. Start tracking your spending to discover places where you may be unknowingly overspending. Save your receipts and write your purchases in a spending journal, categorizing them so you can identify areas where you have a hard time keeping your spending in check."
    }
    @IBAction func but5(_ sender: UIButton) {
        taillebutton(bout1: button5, bout2: button1, bout3: button3, bout4: button4, bout5: button2, bout6: button6, bout7: button7, bout8: button8, bout9: button9, bout10: button10)
        titre.text = "Don’t Commit"
               desc.text = "Just because your income and credit qualify you for a certain loan, doesn’t mean you should take it. Many people naively think the bank wouldn’t approve them for a credit card or loan they can’t afford. The bank only knows your income, as you’ve reported, and the debt obligations included on your credit report, not any other obligations that could prevent you from making your payments on time. It’s up to you to decide whether a monthly payment is affordable based on your income and other monthly obligations."
    }
    @IBAction func but6(_ sender: UIButton) {
         taillebutton(bout1: button6, bout2: button1, bout3: button3, bout4: button4, bout5: button5, bout6: button2, bout7: button7, bout8: button8, bout9: button9, bout10: button10)
        titre.text = "Paying the Best Prices"
        desc.text = "You can make the most of your money comparison shopping, ensuring that you’re paying the lowest prices for products and services. Look for discounts, coupons, and cheaper alternatives whenever you can."
    }
    
    @IBAction func but7(_ sender: UIButton) {
         taillebutton(bout1: button7, bout2: button1, bout3: button3, bout4: button4, bout5: button5, bout6: button6, bout7: button2, bout8: button8, bout9: button9, bout10: button10)
        titre.text = "Save Up "
        desc.text = "The ability to delay gratification will go along way in helping you be better with money. When you put off large purchases, rather than sacrificing more important essentials or putting the purchase on a credit card, you give yourself time to evaluate whether the purchase is necessary and even more time to compare prices. By saving up rather than using credit, you avoid paying interest on the purchase.6﻿ And if you save rather than skipping bills or obligations, well, you don’t have to deal with the many consequences of missing those bills."
    }
    @IBAction func but8(_ sender: UIButton) {
         taillebutton(bout1: button8, bout2: button1, bout3: button3, bout4: button4, bout5: button5, bout6: button6, bout7: button7, bout8: button2, bout9: button9, bout10: button10)
        titre.text = "Limit Card Purchases"
               desc.text = "Credit cards are a bad spender's worst enemy. When you run out of cash, you simply turn to your credit cards without considering whether you can afford to pay the balance. Resist the urge to use your credit cards for purchases you can’t afford, especially on items you don’t really need."
    }
    @IBAction func but9(_ sender: UIButton) {
         taillebutton(bout1: button9, bout2: button1, bout3: button3, bout4: button4, bout5: button5, bout6: button6, bout7: button7, bout8: button8, bout9: button2, bout10: button10)
        titre.text = "Contribute to Savings"
        desc.text = "Depositing money into a savings account each month can help you build healthy financial habits. You can even set it up so the money is automatically transferred from your checking account to your savings account. That way, you don’t have to remember to make the transfer."
    }
    @IBAction func but10(_ sender: UIButton) {
         taillebutton(bout1: button10, bout2: button1, bout3: button3, bout4: button4, bout5: button5, bout6: button6, bout7: button7, bout8: button8, bout9: button9, bout10: button2)
        titre.text = "Practice"
        desc.text = "In the beginning, you may not be used to planning ahead and putting off purchases until you can afford them. The more you make these habits part of your daily life, the easier it is to manage your money, and the better off your finances will be."
    }
}
