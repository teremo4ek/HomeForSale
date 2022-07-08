//
//  IntroViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 07.07.2022.
//

import Foundation
import UIKit

class IntroViewModel {

    var pageArray = [IntroPageHelper]()

    init() {
        print("IntroViewModel created")
        createIntro()
    }

    deinit {
        print("- IntroViewModel ")
    }

    private func createIntro() {

        let fast = IntroPageHelper(
            nameHeader: "Fast",
            nameSub: "You can find home \nfaster than any other application.",
            image: UIImage(named: "icon_fast")!)

        let free = IntroPageHelper(
            nameHeader: "Free",
            nameSub: "App is free forever. No ads.\nNo subscription feels.",
            image: UIImage(named: "icon_gift")!)

        let powerful = IntroPageHelper(
            nameHeader: "Powerful",
            nameSub: "App has no limits on\nthe size of your chats and media.",
            image: UIImage(named: "icon_powerful")!)

        let cloudBased = IntroPageHelper(
            nameHeader: "Cloud-Based",
            nameSub: "App lets you access your\naccount from multiple devices.",
            image: UIImage(named: "icon_cloud")!)

        pageArray.append(fast)
        pageArray.append(free)
        pageArray.append(powerful)
        pageArray.append(cloudBased)
    }
}
