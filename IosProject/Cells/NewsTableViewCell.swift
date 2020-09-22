//
//  NewsTableViewCell.swift
//  IosProject
//
//  Created by IlyesTourki on 6/25/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var images: UIImageView!
    
    @IBOutlet weak var Author: UILabel!
    @IBOutlet weak var title: UILabel!
    
     func setNews(news : News){
              title.text = news.title
              Author.text = news.author
        if(news.image != nil){
            print("///////" + news.image)
            let urll = URL(string: news.image)!
            print(">>>>>>>")
             downloadImage(from: urll)
        }
       
          }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
        func downloadImage(from url: URL) {
            
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.images.image = UIImage(data: data)
                }
            }
        }
}
