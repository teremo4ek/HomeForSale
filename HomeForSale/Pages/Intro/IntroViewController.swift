//
//  IntroViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 07.07.2022.
//

import UIKit
import PureLayout

class IntroViewController: UIPageViewController {

    private var viewModel: IntroViewModel?

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = .white
        self.dataSource = self
        self.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = IntroViewModel()

        setViewControllers([pageIntroViewControllers[0]], direction: .forward, animated: true, completion: nil)

        createButton()
        setStylePageControl()
    }

    lazy var startButton: UIButton = {
        let button = UIButton.newAutoLayout()
        button.layer.cornerRadius = 22
        button.setTitle("Start app", for: .normal)
        button.setTitleColor( .white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .blue
        button.autoSetDimension(.width, toSize: 150.0)
        button.autoSetDimension(.height, toSize: 44.0)
        button.addTarget(self, action: #selector(startIsTapped), for: .touchUpInside)
        return button
    }()

    lazy var pageIntroViewControllers: [PageIntroViewController] = {
        var pageVC = [PageIntroViewController]()
        if  let pages = viewModel?.pageArray {
            for page in pages {
                pageVC.append(PageIntroViewController(pageInfo: page))
            }
        }

        return pageVC
    }()

    private func setStylePageControl() {
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.backgroundColor = .white
    }

    private func createButton() {
        view.addSubview(startButton)

        startButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 60)
        startButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    @objc func startIsTapped(sender: UIButton) {
        print("Start Btn Tapped")
        navigationController?.pushViewController(TabBarController(), animated: true)
        navigationController?.viewControllers.removeFirst()

    }
}

extension IntroViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PageIntroViewController else {
            return nil
        }
        if let index = pageIntroViewControllers.firstIndex(of: viewController) {
            if index > 0 {
                return pageIntroViewControllers[index - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PageIntroViewController else {
            return nil
        }
        if let index = pageIntroViewControllers.firstIndex(of: viewController) {
            if index < pageIntroViewControllers.count - 1 {
                return pageIntroViewControllers[index + 1]
            }
        }

        return nil
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewModel?.pageArray.count ?? 0
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
