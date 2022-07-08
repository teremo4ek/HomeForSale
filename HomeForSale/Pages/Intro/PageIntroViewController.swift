//
//  PageViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 07.07.2022.
//

import UIKit

class PageIntroViewController: UIViewController {

    private let pageInfo: IntroPageHelper!

    init(pageInfo: IntroPageHelper) {
        self.pageInfo = pageInfo

        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var pageIntroView: PageIntroView {
        view as! PageIntroView
    }

    override func loadView() {
        view = PageIntroView()

        pageIntroView.pageImage.image = pageInfo.image
        pageIntroView.nameLabel.text = pageInfo.nameHeader
        pageIntroView.subLabel.text = pageInfo.nameSub
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
