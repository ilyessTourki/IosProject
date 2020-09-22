//
//  ApiHealthViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 6/25/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices

class ApiHealthViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var charge: UIActivityIndicatorView!
    
    @IBOutlet weak var tabview: UITableView!
    var news : [News] = []
    var new : [News] = []
    let HealthApi = "http://newsapi.org/v2/everything?q=health&from=2020-05-30&sortBy=publishedAt&apiKey=614296b2f70c40729a51c891c6b98f3f"
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tabview.delegate = self
        tabview.dataSource =  self
        tabview.rowHeight = 120
        
        consommation()
        
       charge.startAnimating()
       charge.center = view.center
       charge.color = UIColor.red
       run(after: 1){
           
           self.news = self.new
           //print(self.username)
       }
       run(after: 2){
           self.charge.isHidden = true
           self.tabview.reloadData()
       }
    }
    func run(after seconds:Int,completion:@escaping () -> Void){
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            completion()
        }
    }
    
    
    func consommation(){
        AF.request(HealthApi, method: .get).responseJSON
                   {
                       response in
                       //printing response
                      
                       switch response.result {
                       case .success(let value):
                        
                        let jsonData = response.value as! NSDictionary
                        //let titre = jsonData.value(forKey:"title") as! NSString
                        let articles = jsonData.value(forKey:"articles") as! NSArray
                        let titre = articles.value(forKey:"title") as! NSArray
                        let author = articles.value(forKey:"author") as! NSArray
                        let url = articles.value(forKey:"urlToImage") as! NSArray
                        let linksafari = articles.value(forKey:"url") as! NSArray
                        print(author)
                        print(url)
                        let i = titre.count - 1
                        var j = 0
                        while (j <= i )  {
                            let urlj = url[j]
                          print(urlj)
                            
                        
                            
                         let news1 = News(
                         title: titre[j] as! String
                            ,author: author[j] as? String ?? ""
                         ,image: url[j] as? String ?? "https://www.southwestbusinesscouncil.co.uk/wp-content/uploads/2019/06/Screenshot-2019-06-24-at-18.03.43.png" ,
                          linksafari:linksafari[j] as! String
                          )
                          self.new.append(news1)
                          j += 1
                         
                         
                        }
                          
                       case .failure(let error):
                        print(error)
                       }
               }
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return news.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let newss =  news[indexPath.row]
           let cell = tableView.dequeueReusableCell(withIdentifier: "News") as! NewsTableViewCell
           
           cell.setNews(news: newss)
           
          
           return cell
       }
       
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let newsapi =  news[indexPath.row]
        showSafariVC(for: newsapi.linksafari)
        
       }
    func showSafariVC(for url:String)
    {
        guard let  url=URL(string: url) else {
            //show alert error
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC , animated: true)
    }
}
