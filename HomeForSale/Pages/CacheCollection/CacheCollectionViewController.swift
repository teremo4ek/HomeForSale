//
//  CacheCollectionViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 02.06.2022.
//

import UIKit

class CacheCollectionViewController: UIViewController {

    private let collectionCellReuseIdentifier = "collectionCellReuseIdentifier"
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

    var viewModel: CacheCollectionViewModel!

    var cacheCollectionView: CacheCollectionView {
        view as! CacheCollectionView
    }

    override func loadView() {
        view = CacheCollectionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        cacheCollectionView.collectionView.delegate = self
        cacheCollectionView.collectionView.dataSource = self
        cacheCollectionView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: collectionCellReuseIdentifier)

        viewModel?.delegate = self

        DispatchQueue.global(qos: .default).async { [weak self] in
            self?.viewModel?.fetchData()
        }
    }

    deinit {
        print("Freeing up the HomesViewController")
    }

    // MARK: - - Update Interface
    private func updateInterface() {
//        DispatchQueue.main.async { [weak self] in
//            print("CacheCollectionViewController - updateInterface()")
//        }
    }
}

extension CacheCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
      }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellReuseIdentifier, for: indexPath) as! CollectionViewCell

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel

        return cell
    }

}

extension CacheCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
      }

}

extension CacheCollectionViewController: NetworkDataDelegate {
    func onComplition() {
        self.updateInterface()
    }

    func onHomeInfoCellUpdated(indexes: [Int]) {

    }
}
