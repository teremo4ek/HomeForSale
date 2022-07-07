//
//  Coordinator.swift
//  HomeForSale
//
//  Created by Yury Bely on 19.05.2022.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()

    func viewController() -> UIViewController
}
