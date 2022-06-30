//
//  CacheDetailViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 29.06.2022.
//

import UIKit

class CacheDetailViewController: UIViewController {

    var viewModel: CacheDetailViewModel!

    var cacheDetailView: CacheDetailView {
        view as! CacheDetailView
    }

    override func loadView() {
        view = CacheDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.delegate = self

        cacheDetailView.idLabel.text = viewModel.photoID
        cacheDetailView.likeButton.setImage(viewModel?.likeImage, for: .normal)
        cacheDetailView.likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)

        viewModel.getImage()
    }

    func updateElements() {
        cacheDetailView.image.image = viewModel?.largeImage ??  UIImage(systemName: "doc")
        cacheDetailView.likeButton.setImage(viewModel?.likeImage, for: .normal)
    }

    @objc func likeAction(sender: UIButton!) {
        viewModel.likeAction()
    }

}

extension CacheDetailViewController: NetworkDataDelegate {
    func onImageDownloaded(id: String) {
        print("CacheDetailViewController.NetworkDataDelegate.onImageDownloaded \(id)")

        DispatchQueue.main.async { [weak self] in
            self?.updateElements()
        }
    }

    func onComplition() {
        print("CacheDetailViewController.NetworkDataDelegate.onComplition")
    }

    func onHomeInfoCellUpdated(indexPaths: [IndexPath]) {
        print("CacheDetailViewController.NetworkDataDelegate.onHomeInfoCellUpdated \(indexPaths)")
    }
}
