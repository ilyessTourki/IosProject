//
//  MenuViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/20/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit
enum MenuType : Int {
    case profile
    case mychallenges
    case deconnexion
}
class MenuViewController: UITableViewController {

     var didTapMenuType: ((MenuType) -> Void)?

       override func viewDidLoad() {
           super.viewDidLoad()
        let imageView = UIImageView(image: UIImage(named: "backmenu4"))
    /*let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)*/
        self.tableView.backgroundView = imageView
       
       
       
           // Do any additional setup after loading the view.
       }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }

       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           guard let menuType = MenuType(rawValue: indexPath.row) else { return }
           dismiss(animated: true) { [weak self] in
               print("Dismissing: \(menuType)")
               self?.didTapMenuType?(menuType)
           }
        
    }

   

}
