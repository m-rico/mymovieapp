//
//  ExTabBar.swift
//  mymovie
//
//  Created by user on 10/11/22.
//

import Foundation
import UIKit



class ExTabBar: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        delegate = self
        
        // TAB BAR BACKGROUND COLOR HERE.
        UITabBar.appearance().barTintColor = UIColor.systemBackground
        // TAB BAR ICONS COLOR HERE.
        UITabBar.appearance().tintColor = UIColor.blue
        UITabBar.appearance().isTranslucent = true
        if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                
                // TAB BAR BACKGROUND COLOR HERE. (same as above)
                appearance.backgroundColor = UIColor.systemBackground
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
        
        let mainRouter = MainRouter.start()
        let genreRouter = GenreRouter.start()
        guard let initialVC = mainRouter.entry, let GenreVC = genreRouter.entry else { return  }
        
        let vc1 = UINavigationController(rootViewController: initialVC)
        let vc2 = UINavigationController(rootViewController: GenreVC)
        
        vc1.tabBarItem.image = UIImage(systemName: "house.circle")
        vc1.title = "Home"
//        vc1.navigationBar.backgroundColor = .white
        vc2.tabBarItem.image = UIImage(systemName: "safari")
        vc2.title = "Discover"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2], animated: true)
    }
}
