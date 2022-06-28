//
//  CacheCollectionViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 02.06.2022.
//

import UIKit

class CacheCollectionViewController: UIViewController {

    private let collectionCellReuseIdentifier = "collectionCellReuseIdentifier"
    let searchController = UISearchController(searchResultsController: nil)
    var imageViewScale = 1.0
    var imageViewSize: CGSize = .zero
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

        searchController.searchBar.placeholder = "Search...."
        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        cacheCollectionView.collectionView.delegate = self
        cacheCollectionView.collectionView.prefetchDataSource = self
        cacheCollectionView.collectionView.dataSource = self
        cacheCollectionView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: collectionCellReuseIdentifier)

        viewModel?.delegate = self

        DispatchQueue.global(qos: .default).async { [weak self] in
            self?.viewModel?.fetchData(text: "house")
        }
    }

    deinit {
        print("Freeing up the HomesViewController")
    }

    // MARK: - - Update Interface
    private func updateInterface() {
        print("CacheCollectionViewController - updateInterface()")
        cacheCollectionView.updateCollectionView()
    }
}

extension CacheCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSearchesPhrases()
      }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellReuseIdentifier, for: indexPath) as! CollectionViewCell

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cellViewModel?.imageViewSize = imageViewSize
        cellViewModel?.imageViewScale = imageViewScale
        cellViewModel?.loadImage()
        cell.viewModel = cellViewModel

        return cell
    }
}

extension CacheCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        // print("sizeForItemAt indexPath=\(indexPath); width=\(widthPerItem)")

        if imageViewSize == .zero {
            imageViewSize = CGSize(width: widthPerItem, height: widthPerItem)
            imageViewScale = collectionView.traitCollection.displayScale

            print("imageViewSize =\(imageViewSize); imageViewScale=\(imageViewScale)")
        }

        return CGSize(width: widthPerItem, height: widthPerItem)
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
      }

}

extension CacheCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("prefetchItemsAt \(indexPaths)")
        viewModel?.downloadImage(paths: indexPaths)
    }
}

extension CacheCollectionViewController: NetworkDataDelegate {
    func onImageDownloaded(id: String) {
        print("CacheCollectionViewController.NetworkDataDelegate.onImageDownloaded \(id)")
    }

    func onComplition() {
        print("CacheCollectionViewController.NetworkDataDelegate.onComplition")
        self.updateInterface()
    }

    func onHomeInfoCellUpdated(indexPaths: [IndexPath]) {
        print("CacheCollectionViewController.NetworkDataDelegate.onHomeInfoCellUpdated \(indexPaths)")
        DispatchQueue.main.async { [weak self] in
            self?.cacheCollectionView.collectionView.reloadItems(at: indexPaths)
        }
    }
}

// MARK: - SearchControllerDelegate extension
extension CacheCollectionViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
    }
}

// MARK: - SearchBarDelegate extension
extension CacheCollectionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            print("searchBar text is empty")
            return
        }
        // print("searchBar text: \"\(searchText)\" ")
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing text: \"\(String(describing: searchBar.text))\" ")
        guard
          let text = searchBar.text,
          !text.isEmpty
        else { return }

        viewModel.fetchData(text: text)

    }
}
