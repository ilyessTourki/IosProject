//
//  NtestifilmenuViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 5/7/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//
import Alamofire
import UIKit

class NtestifilmenuViewController:
    
UIViewController ,UITabBarControllerDelegate {
    
    @IBOutlet weak var firstlab: UILabel!
    @IBOutlet weak var tomanage: UILabel!
    @IBOutlet weak var fretimes: UILabel!
    @IBOutlet weak var tosleep: UILabel!
    @IBOutlet weak var wakeup: UILabel!
    @IBOutlet weak var charge: UIActivityIndicatorView!
    @IBOutlet weak var free: UILabel!
    @IBOutlet weak var sleep: UILabel!
    @IBOutlet weak var more: UITabBarItem!
    @IBOutlet weak var star: UITabBarItem!
    @IBOutlet weak var texti: UILabel!
    @IBOutlet weak var iltext: UIButton!
    @IBOutlet weak var tabBar: UITabBar!
    var hourmts = 1
    var miunutemts = 1
    var pmmts = ""
    
    var mts = ""
    var mte = ""
    
    var tts = ""
    var tte = ""
    
    var wts = ""
    var wte = ""
    
    var fts = ""
    var fte = ""
    
    var thts = ""
    var thte = ""
    
    var sts = ""
    var ste = ""
    var timer = Timer()
    var time = 0
    var hesbadeux = 0
    var userid = (UserDefaults.standard.value(forKey: "id") as! NSString).doubleValue
    let Time_Affiche = "http://192.168.64.2/miniprojet/Time/affiche.php"
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
        texti.isHidden = true
        free.isHidden = true
        sleep.isHidden = true
        wakeup.isHidden = true
        tosleep.isHidden = true
        fretimes.isHidden = true
        charge.isHidden = true
        tomanage.isHidden = true
        firstlab.isHidden = true

        consomation()
             
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        texti.isHidden = true
        free.isHidden = true
        sleep.isHidden = true
        wakeup.isHidden = true
        tosleep.isHidden = true
        fretimes.isHidden = true
        charge.isHidden = true
        tomanage.isHidden = true
        firstlab.isHidden = true

        consomation()
    }
    
    func run(after seconds:Int,completion:@escaping () -> Void){
           let deadline = DispatchTime.now() + .seconds(seconds)
           DispatchQueue.main.asyncAfter(deadline: deadline){
               completion()
           }
       }
    func gettime(stin :String){
        
        let Fmts = stin.index( stin.startIndex, offsetBy: 0)
        let Smts = stin.index(stin.endIndex, offsetBy:-7)
        let fmts =  stin.index( stin.startIndex, offsetBy: 3)
        let smts = stin.index(stin.endIndex, offsetBy:-4)
        let pmts =  stin.index( stin.startIndex, offsetBy: 6)
        let  mmts = stin.index(stin.endIndex, offsetBy:-1)
        hourmts = Int(String(stin[Fmts ... Smts]))!
        miunutemts = Int(String(stin[fmts ... smts]))!
        pmmts = String(stin[pmts ... mmts])
        
    }
    func consomation()
    {
        let parameter: Parameters=[
            "userid":userid
        ]
        
        //Sending http post request
        AF.request(Time_Affiche, method: .get, parameters: parameter).responseJSON
            {
                response in
                //printing response
                let jsonData = response.value as! NSDictionary
                
                
                print(response)
                
                
                switch response.result {
                case .success:
                    print("Success")
                    
                    if nil != jsonData.value(forKey: "mts"){
                        self.mts = jsonData.value(forKey:"mts") as! String
                        self.mte = jsonData.value(forKey:"mte") as! String
                        
                        self.tts = jsonData.value(forKey:"tts") as! String
                        self.tte = jsonData.value(forKey:"tte") as! String
                        
                        self.wts = jsonData.value(forKey:"wts") as! String
                        self.wte = jsonData.value(forKey:"wte") as! String
                        
                        self.fts = jsonData.value(forKey:"fts") as! String
                        self.fte = jsonData.value(forKey:"fte") as! String
                        
                        self.thts = jsonData.value(forKey:"thts") as! String
                        self.thte = jsonData.value(forKey:"thte") as! String
                        
                        self.sts = jsonData.value(forKey: "sts") as! String
                        self.ste = jsonData.value(forKey: "ste") as! String
                        
                        
                        self.tomanage.isHidden = false
                        self.charge.isHidden = false
                        self.charge.startAnimating()
                        self.run(after: 1){
                            self.charge.isHidden = true
                            self.texti.isHidden = false
                            self.free.isHidden = false
                            self.sleep.isHidden = false
                            self.wakeup.isHidden = false
                            self.tosleep.isHidden = false
                            self.fretimes.isHidden = false
                        }
                        self.tabBar.selectedItem = self.tabBar.items?.first
                        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.increaseTimer), userInfo: nil, repeats: true)
                    }else{
                        self.firstlab.isHidden = false
                    }
                    
                case .failure(let error):
                    print(error)
                }
                //getting the json value from the server
                
                
        }
        
    }
    func findDateDiff(time1Str: String, time2Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"
        
        guard let time1 = timeformatter.date(from: time1Str),
            let time2 = timeformatter.date(from: time2Str) else { return "" }
        
        //You can directly use from here if you have two dates
        
        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        let intervalInt = Int(interval)
        return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)) Hours \(Int(minute)) Minutes"
    }
    @IBAction func test(_ sender: UIButton) {
        
        
    }
    
    @objc func increaseTimer(){
        time+=1
        
        
        
        if time > time-1 {
            
            
            
            if tabBar.selectedItem ==  tabBar.items![0]{
                self.gettime(stin: self.mts)
                
                
                if(miunutemts == 0){
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) +  " " + pmmts
                        
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : "  + String(miunutemts) + " " + pmmts
                        
                    }
                }
                
                if(miunutemts == 0){
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = 12
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = hourmts + 3
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) +  " " + pmmts
                        hesbadeux = 12
                        
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        self.hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : "  + String(miunutemts) + " " + pmmts}
                    hesbadeux = hourmts + 3
                }
                
                self.gettime(stin: self.mte)
                let freetime = hesbadeux - hourmts
                free.text = String(freetime) + " Hours"
                
            }
            
            
            
            
            if tabBar.selectedItem ==  tabBar.items![1] {
                
                self.gettime(stin: self.tts)
                
                
                if(miunutemts == 0){
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) +  " " + pmmts
                        
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : "  + String(miunutemts) + " " + pmmts
                        
                    }
                }
                
                if(miunutemts == 0){
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = 12
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = hourmts + 3
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) +  " " + pmmts
                        hesbadeux = 12
                        
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        self.hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : "  + String(miunutemts) + " " + pmmts}
                    hesbadeux = hourmts + 3
                }
                
                self.gettime(stin: self.tte)
                let freetime = hesbadeux - hourmts
                free.text = String(freetime) + " Hours"
                
                
                
                
            }
            if tabBar.selectedItem ==  tabBar.items![2]{
                self.gettime(stin: self.wts)
                
                
                if(miunutemts == 0){
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) +  " " + pmmts
                        
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : "  + String(miunutemts) + " " + pmmts
                        
                    }
                }
                
                if(miunutemts == 0){
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = 12
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = hourmts + 3
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) +  " " + pmmts
                        hesbadeux = 12
                        
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        self.hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : "  + String(miunutemts) + " " + pmmts}
                    hesbadeux = hourmts + 3
                }
                
                self.gettime(stin: self.wte)
                let freetime = hesbadeux - hourmts
                free.text = String(freetime) + " Hours"
                
            }
            if tabBar.selectedItem ==  tabBar.items![3]{
                self.gettime(stin: self.thts)
                
                
                if(miunutemts == 0){
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) +  " " + pmmts
                        
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : "  + String(miunutemts) + " " + pmmts
                        
                    }
                }
                
                if(miunutemts == 0){
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = 12
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = hourmts + 3
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) +  " " + pmmts
                        hesbadeux = 12
                        
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        self.hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : "  + String(miunutemts) + " " + pmmts}
                    hesbadeux = hourmts + 3
                }
                
                self.gettime(stin: self.thte)
                let freetime = hesbadeux - hourmts
                free.text = String(freetime) + " Hours"
                
            }
            if tabBar.selectedItem ==  tabBar.items![4]{
                self.gettime(stin: self.fts)
                
                print(miunutemts)
                
                if(miunutemts == 0){
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) +  " " + pmmts
                        
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : "  + String(miunutemts) + " " + pmmts
                        
                    }
                }
                
                if(miunutemts == 0){
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = 12
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = hourmts + 3
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) +  " " + pmmts
                        hesbadeux = 12
                        
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        self.hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : "  + String(miunutemts) + " " + pmmts}
                    hesbadeux = hourmts + 3
                }
                
                self.gettime(stin: self.fte)
                let freetime = hesbadeux - hourmts
                free.text = String(freetime) + " Hours"
                
                
            }
            
            
            if tabBar.selectedItem ==  tabBar.items![5]{
                self.gettime(stin: self.sts)
                
                if(miunutemts == 0){
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 2) == 0)
                    {
                        texti.text = String( hourmts - 2 ) + String( hourmts - 2 ) + " : " + String(miunutemts) +  " " + pmmts
                        
                        
                    }
                        
                    else{
                        
                        texti.text = String( hourmts - 2 ) + " : "  + String(miunutemts) + " " + pmmts
                        
                    }
                }
                
                if(miunutemts == 0){
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = 12
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : " + String(miunutemts) + String(miunutemts) + " " + pmmts
                        hesbadeux = hourmts + 3
                        
                    }
                }
                    
                    
                    
                    
                else{
                    if ((hourmts - 9) == 0)
                    {
                        sleep.text = String( hourmts - 9 ) + String( hourmts - 9 ) + " : " + String(miunutemts) +  " " + pmmts
                        hesbadeux = 12
                        
                        
                    }
                    else if ((hourmts - 9) < 0 )
                    {
                        let hesba = 9 - hourmts
                        self.hesbadeux =  12 - hesba
                        
                        sleep.text = String( hesbadeux )  + " : " + String(miunutemts) + " " + "PM"
                        
                        
                    }
                        
                    else{
                        sleep.text = String( hourmts - 9 ) + " : "  + String(miunutemts) + " " + pmmts}
                    hesbadeux = hourmts + 3
                }
                
                self.gettime(stin: self.ste)
                let freetime = hesbadeux - hourmts
                free.text = String(freetime) + " Hours"
                
                
            }
            
        }
    }
}

