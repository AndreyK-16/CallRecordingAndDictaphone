//
//  MainTabBarController.swift
//  DictophoneApp
//
//  Created by Андрей К on 21.01.2020.
//  Copyright © 2020 Андрей Кальдяев. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

       view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
       
       let dictaphoneVC = DictaphoneViewController()
       
       let saveAudioVC = SavedAudioViewController()
       
        viewControllers = [generateNavController(rootViewController: dictaphoneVC, title: "Dictaphone", image: #imageLiteral(resourceName: "microphone")),
                           generateNavController(rootViewController: saveAudioVC, title: "Saved", image: #imageLiteral(resourceName: "save")) ]
       
    }
    
    private func generateNavController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }

}
