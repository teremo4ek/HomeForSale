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
    func onImageDownloaded(id: String) {

    }

    func onComplition() {
        self.updateInterface()
    }

    func onHomeInfoCellUpdated(indexPaths: [IndexPath]) {

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
