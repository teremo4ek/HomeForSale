//
//  TabBarControlle.swift
//  HomeForSale
//
//  Created by Yury Bely on 06.07.2022.
//

import UIKit

class TabBarControlle: UITabBarController {

    private let viewModel: TapBarViewModel = TapBarViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Main Page"

        setupTabBar()
    }

    // MARK: private

    private func setupTabBar() {

        self.viewControllers = viewModel.Items.map {
            switch $0 {
            case .hauseDetail:
                let coordinator = HomesInfoTableCoordinator(presentingController: nil)
                let viewController = coordinator.viewController()
                return self.wrappedInNavigationController(with: viewController, title: $0.title)
            case .cacheCollection:
                let coordinator = CacheCollectionCoordinator(presentingController: nil)
                let viewController = coordinator.viewController()
                return self.wrappedInNavigationController(with: viewController, title: $0.title)
            }
        }
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = viewModel.Items[$0].title
            $1.tabBarItem.image = UIImage(systemName: viewModel.Items[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
        }
    }

    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {
        return UINavigationController(rootViewController: with)
    }

}
