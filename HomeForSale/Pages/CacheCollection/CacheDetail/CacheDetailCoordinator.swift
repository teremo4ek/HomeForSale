//
//  CacheDetailCoordinator.swift
//  HomeForSale
//
//  Created by Yury Bely on 29.06.2022.
//

import Foundation
import UIKit

final class CacheDetailCoordinator: Coordinator {
    private var presentingController: UINavigationController?
    private var photo: FlickrPhoto!

    init(presentingController: UINavigationController?, photo: FlickrPhoto) {
        self.presentingController = presentingController
        self.photo = photo
    }

    func start() {
        presentingController?.pushViewController(viewController(), animated: true)
    }

    func viewController() -> UIViewController {
        let viewModel = CacheDetailViewModel(photo)
        let viewController = CacheDetailViewController()
        viewController.viewModel = viewModel
        return viewController
    }

}
