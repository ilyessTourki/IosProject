//
//  HomeViewController.swift
//  IosProject
//
//  Created by IlyesTourki on 4/15/20.
//  Copyright © 2020 IlyesTourki. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
   let transiton = SlideInTransition()
    var topView: UIView?
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
 
    }

    @IBAction func lista(_ sender: UIButton) {
        let sportsetting = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listec") as! ListeChallengesViewController;()
         sportsetting.modalPresentationStyle = .fullScreen
        sportsetting.type = "time"
        self.present(sportsetting, animated: true, completion: nil)
    }
    @IBAction func chalengemoney(_ sender: UIButton) {
        let sportsetting = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listec") as! ListeChallengesViewController;()
         sportsetting.modalPresentationStyle = .fullScreen
         sportsetting.type = "money"
        self.present(sportsetting, animated: true, completion: nil)
    }
    @IBAction func chhealth(_ sender: UIButton) {
        let sportsetting = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listec") as! ListeChallengesViewController;()
         sportsetting.modalPresentationStyle = .fullScreen
         sportsetting.type = "health"
        self.present(sportsetting, animated: true, completion: nil)
    }
    @IBAction func slidedmenu(_ sender: UIBarButtonItem) {
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
                           let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "signin") as! LoginViewController;()
                            newViewController.modalPresentationStyle = .fullScreen
                            self.present(newViewController, animated: true, completion: nil)
                             // self.presentingViewController?.presentingViewController?.viewDidDisappear(true)
                                                       //self.topView = view
                                print("m")
                                  break
                              }
                
            }
    
    @IBAction func gift(_ sender: UIButton) {
       
    }
    
           

        }
        extension HomeViewController: UIViewControllerTransitioningDelegate {
            func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
                transiton.isPresenting = true
                return transiton
            }

            func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
                transiton.isPresenting = false
                return transiton
            }
        }
