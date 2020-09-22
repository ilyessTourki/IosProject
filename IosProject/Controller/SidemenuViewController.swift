//
//  SidemenuViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/24/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit
let transiton = SlideInTransition()
var topView: UIView?
    class SidemenuViewController: UITabBarController {
    override func viewDidLoad() {
        

        super.viewDidLoad()
        setNavigationBar()
        self.view.layoutIfNeeded()
        
      
    }
    
        func setNavigationBar() {
//            let screenSize: CGRect = UIScreen.main.bounds
//             let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 10))
//            
//        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(done))
//            // navItem.rightBarButtonItem = doneItem
//             navBar.setItems([doneItem], animated: false)
//             self.view.addSubview(navBar)
         }
        
        
        @objc func done() {
            
        }
    @IBAction func selectmenu(_ sender: UIBarButtonItem) {
         
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
                      menuViewController.didTapMenuType = { menuType in
                          self.transitionToNew(menuType)
                      }
                      menuViewController.modalPresentationStyle = .overCurrentContext
                      menuViewController.transitioningDelegate = self
                      present(menuViewController, animated: true)
                  }

                  func transitionToNew(_ menuType: MenuType) {
                      let title = String(describing: menuType).capitalized
                      self.title = title

                      topView?.removeFromSuperview()
                      switch menuType {
                      case .profile:
                        // let newViewController = TestViewController()
                         // self.navigationController?.pushViewController(newViewController, animated: true)
                           let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                           let newViewController = storyBoard.instantiateViewController(withIdentifier: "newViewController") as! TestViewController;()
                           newViewController.modalPresentationStyle = .fullScreen
                           self.present(newViewController, animated: true, completion: nil)
                           /*guard let signin = storyboard?.instantiateViewController(withIdentifier: "sigin")
                              
                               else { return}*/
                           //present(signin,animated: true)
                           
                        //  default:
                         
                      case .mychallenges:
                        
                          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                          let challengeview = storyBoard.instantiateViewController(withIdentifier: "challengeview") as! MyChallengesViewController;()
                          challengeview.modalPresentationStyle = .fullScreen
                          self.present(challengeview, animated: true, completion: nil)
                         // self.topView = view
                        
                      case .deconnexion:
                        UserDefaults.standard.removeObject(forKey: "email")
                                                self.presentingViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
                          break
                      }
        
    }
        
   

}
extension SidemenuViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
