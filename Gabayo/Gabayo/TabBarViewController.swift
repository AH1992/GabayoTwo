//
//  TabBarViewController.swift
//  Gabayo
//
//  Created by Ali Hassan on 4/27/23.
//

import UIKit

class TabBarViewController: UITabBarController {
   
   lazy var miniPlayer: PlayerViewController = {
       let miniPlayerVC = PlayerViewController()
       miniPlayerVC.view.translatesAutoresizingMaskIntoConstraints = false
      return miniPlayerVC
   }()
   
   lazy var containerView: UIView = {
       let uiView = UIView()
       uiView.translatesAutoresizingMaskIntoConstraints = false
       return uiView
   }()

   override func viewDidLoad() {
       super.viewDidLoad()
       addChildViews()
       setConstraints()
      
  }
    
   func addChildViews(){
      view.addSubview(containerView)
       addChild(miniPlayer)
        containerView.addSubview(miniPlayer.view)
       didMove(toParent: self)
//    }
//    
//    func setConstraints(){
//        NSLayoutConstraint.activate([
//            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            containerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor),
//            containerView.heightAnchor.constraint(equalToConstant: 70.0),
//
//            miniPlayer.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            miniPlayer.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            miniPlayer.view.topAnchor.constraint(equalTo: containerView.topAnchor),
//            miniPlayer.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
//
//        
//        ])
//    }
//    


}
