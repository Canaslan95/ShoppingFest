//
//  TabBarController.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 2.06.2021.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
    }
    
    func setTabBarItems() {
        // HomeController
        let homeViewModel = HomeViewModel()
        let homeController = HomeViewController(viewModel: homeViewModel)
        homeController.title = "Home"
        homeController.tabBarItem.image = UIImage(systemName: "homekit")
        let navigationHomeController = UINavigationController(rootViewController: homeController)
        
        // ShoppingCartController
        let viewModel = BasketViewModel()
        let basketController = BasketViewController(viewModel: viewModel)
        basketController.title = "Basket"
        basketController.tabBarItem.image = UIImage(systemName: "cart")
        let navigationBasketController = UINavigationController(rootViewController: basketController)
        
        let controllers = [navigationHomeController, navigationBasketController]
        self.viewControllers = controllers
    }
    
}
