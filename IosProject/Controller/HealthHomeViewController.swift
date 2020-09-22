//
//  HealthHomeViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 6/22/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit
import Alamofire

class HealthHomeViewController: UIViewController {

    @IBOutlet weak var firstlab: UILabel!
    @IBOutlet weak var cgain: UILabel!
    @IBOutlet weak var cdef: UILabel!
    @IBOutlet weak var close: UILabel!
    @IBOutlet weak var losew: UILabel!
    @IBOutlet weak var gainw: UILabel!
    @IBOutlet weak var charge: UIActivityIndicatorView!
    @IBOutlet weak var inter1: UILabel!
    @IBOutlet weak var inter4: UILabel!
    @IBOutlet weak var inter3: UILabel!
    @IBOutlet weak var inter2: UILabel!
    @IBOutlet weak var bmi4: UILabel!
    @IBOutlet weak var bmi3: UILabel!
    @IBOutlet weak var bmi2: UILabel!
    @IBOutlet weak var bmi1: UILabel!
    @IBOutlet weak var interpretation: UILabel!
    @IBOutlet weak var BMItable: UILabel!
    @IBOutlet weak var BMIdef: UILabel!
    @IBOutlet weak var BMICadre: UILabel!
    @IBOutlet weak var BMI: UILabel!
    @IBOutlet weak var tabbar: UITabBar!
    var userid = (UserDefaults.standard.value(forKey: "id") as! NSString).doubleValue
    let Health_Affiche = "http://192.168.64.2/miniprojet/Time/healthtest.php"
    var height = ""
    var weight = ""
    var imc = ""
    var sexe = ""
    var age = ""
    var calorie : Float = 0
    var timer = Timer()
    var time = 0
   
    override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     self.view.layoutIfNeeded()
     self.loadData();
          
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func loadData() {
        // code to load data from network, and refresh the interface
        cdef.isHidden = true
        close.isHidden = true
        cgain.isHidden = true
        inter1.isHidden = true
        inter2.isHidden = true
        inter3.isHidden = true
        inter4.isHidden = true
        bmi1.isHidden = true
        bmi2.isHidden = true
        bmi3.isHidden = true
        bmi4.isHidden = true
        BMItable.isHidden = true
        interpretation.isHidden = true
        BMIdef.isHidden=true
        BMI.isHidden = true
        BMICadre.isHidden = true
        charge.isHidden = true
        firstlab.isHidden = true
        consomation()
    }
    func consomation()
       {
           let parameter: Parameters=[
               "userid":userid
           ]
           
           //Sending http post request
           AF.request(Health_Affiche, method: .get, parameters: parameter).responseJSON
               {
                   response in
                   //printing response
                
                   let jsonData = response.value as! NSDictionary
                   
                   
                print(response.result)
                   
                   
                   switch response.result {
                   case .success:
                       print("Success")
                       if nil != jsonData.value(forKey: "height"){
                        
                        self.height = jsonData.value(forKey:"height") as! String
                        self.weight = jsonData.value(forKey:"weight") as! String
                        self.imc = jsonData.value(forKey:"imc") as! String
                        self.sexe = jsonData.value(forKey:"sexe") as! String
                        self.age = jsonData.value(forKey:"age") as! String
                        
                        self.charge.isHidden = false
                        self.charge.startAnimating()
                        
                        self.run(after: 1){
                                   self.charge.isHidden = true
                            self.tabbar.selectedItem = self.tabbar.items?.first
                               }
                        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.increaseTimer), userInfo: nil, repeats: true)
                        
                       }else{
                        self.firstlab.isHidden = false
                    }
                       
                      
                    
                       ///////////////////////////////////////////////////////////////////////////////////
                       
                       
                   case .failure(let error):
                       print(error)
                   }
                   //getting the json value from the server
                   
                   
           }
           
       }
    
      func run(after seconds:Int,completion:@escaping () -> Void){
             let deadline = DispatchTime.now() + .seconds(seconds)
             DispatchQueue.main.asyncAfter(deadline: deadline){
                 completion()
             }
         }

     @objc func increaseTimer(){
           time+=1
           
           
           
           if time > time-1 {
               
               
               
            if tabbar.selectedItem ==  tabbar.items![0]{
                losew.isHidden = true
                gainw.isHidden = true
                cdef.isHidden = true
                close.isHidden = true
                cgain.isHidden = true
                inter1.isHidden = false
                inter2.isHidden = false
                inter3.isHidden = false
                inter4.isHidden = false
                bmi1.isHidden = false
                bmi2.isHidden = false
                bmi3.isHidden = false
                bmi4.isHidden = false
                BMItable.isHidden = false
                interpretation.isHidden = false
                BMIdef.isHidden=false
                BMI.isHidden = false
                BMICadre.isHidden = false
                BMI.text = "BMI : " + imc.prefix(5)
                if ( Float(imc)! < 18.5){
                    BMICadre.text = "BMI < 18.5 : underweight "
                    BMIdef.text = "Your weight appears too low compared to your height. This low body mass index (BMI) may be the consequence of a pathology, but itself can expose to a certain number of risks for your health (deficiencies, anemia, osteoporosis ...). Talk to your doctor. He can research the cause of this thinness and advise you. "
                }
                if ( 18.5 < Float(imc)! && Float(imc)! < 25 ){
                    BMICadre.text = "18.5 < BMI < 24,9 : normal weight "
                    BMIdef.text = " Your weight is adapted to your height. Keep your eating habits to maintain an ideal body mass index (BMI) and a weight that ensures optimal health. A balanced diet, without excess fat, combined with regular physical activity will help you maintain your ideal weight. "
                }
                if ( 25 < Float(imc)!  && Float(imc)! < 30 ){
                    BMICadre.text = "25 < BMI < 29,9 : overweight "
                    BMIdef.text = "Your weight is starting to get too high for your height. In the long term, a high body mass index (BMI) has health consequences. Being overweight leads to an increased risk of metabolic (diabetes), heart, respiratory, joint and cancer diseases. If you want to start a diet to lose weight, talk to your doctor beforehand. "
                }
                if ( Float(imc)! > 30){
                    BMICadre.text = "BMI > 30 : obesity "
                    BMIdef.text = " Your weight is too high for your height. From a medical point of view, obesity is an excess of fat mass with health consequences. Being overweight leads to an increased risk of metabolic (diabetes), heart, respiratory, joint and cancer diseases. If you want to start a diet to lose weight, talk to your doctor beforehand."
                }
                
            }
            if tabbar.selectedItem ==  tabbar.items![1]{
                
                losew.isHidden = false
                gainw.isHidden = false
                cdef.isHidden = false
                close.isHidden = false
                cgain.isHidden = false
                inter1.isHidden = true
                inter2.isHidden = true
                inter3.isHidden = true
                inter4.isHidden = true
                bmi1.isHidden = true
                bmi2.isHidden = true
                bmi3.isHidden = true
                bmi4.isHidden = true
                BMItable.isHidden = true
                interpretation.isHidden = true
                BMICadre.isHidden = true
                BMIdef.isHidden = true
                if (sexe == "male" ){
                    calorie = 10 * Float(weight)! + 6.25 * Float(height)! - 5 * Float(age)! + 5
                }
                else { calorie = 10 * Float(weight)! + 6.25 * Float(height)! - 5 * Float(age)! - 161 }
                
                BMI.text = "Caloric needs : " + String(Int(calorie)) + " /Day"
                let maigrir = calorie * 0.8
                let grossir = calorie * 1.2
                gainw.text = String(Int(maigrir)) + "/Day"
                losew.text = String(Int(grossir)) + "/Day"
                
            }
        }
    }
                   
}
