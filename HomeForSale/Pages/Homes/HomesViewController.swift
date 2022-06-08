//
//  HomesController.swift
//  HomeForSale
//
//  Created by Yury Bely on 23.05.2022.
//

import UIKit

class HomesViewController: UIViewController {

    private let homeInfoCellReuseIdentifier = "homeCellReuseIdentifier"

    var viewModel: HomesViewModel!

    var homesView: HomesView {
        view as! HomesView
    }

    override func loadView() {
        view = HomesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        homesView.tableView.delegate = self
        homesView.tableView.dataSource = self
        homesView.tableView.register(HomeInfoTableViewCell.self, forCellReuseIdentifier: homeInfoCellReuseIdentifier)

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
        DispatchQueue.main.async { [weak self] in
            print("MainTableViewController - updateInterface()")
            self?.homesView.tableView.reloadData()
        }
    }

    private func updateRows( _ indexes: [Int]) {
        if !indexes.isEmpty {
            DispatchQueue.main.async { [weak self] in
                var indexPaths = [IndexPath]()
                for index in indexes {
                    indexPaths.append(IndexPath(row: index, section: 0))
                    print("MainTableViewController - updateRow \(index)")
                }
                self?.homesView.tableView.reloadRows(at: indexPaths, with: .none)
            }
        }

    }
}

extension HomesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeInfoCellReuseIdentifier, for: indexPath) as! HomeInfoTableViewCell

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel

//        cell.layoutIfNeeded() // Ensure imageView is its final size.

        var imageViewSize = cell.houseImage.bounds.size
        let scale = tableView.traitCollection.displayScale
        if imageViewSize == .zero {
            imageViewSize = cell.bounds.size
            // print("cell.row=\(indexPath.row) cellViewSize \(imageViewSize); scale \(scale)")
        }
        // print("cell.row=\(indexPath.row) imageViewSize \(imageViewSize); scale \(scale)")
        viewModel.downsampleImage(forIndexPath: indexPath, to: imageViewSize, scale: scale)

        return cell
    }
}

extension HomesViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // Asynchronously decode and downsample every image we are about to show
        for indexPath in indexPaths {
            print("prefetchItemsAt \(indexPath.row)")
        }
    }

}

extension HomesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print("Row: \(indexPath.row)")

        let coordinator = HomeDetailCoordinator(presentingController: navigationController)
        coordinator.start()
    }
}

extension HomesViewController: NetworkDataDelegate {
    func onImageDownloaded(id: String) {

    }

    func onComplition() {
        print("HomeViewController.onComplition")
        self.updateInterface()
    }

    func onHomeInfoCellUpdated(indexPaths: [IndexPath]) {
        let rows = indexPaths.map { indexPath in
            indexPath.row
        }
        print("HomeViewController.onHomeInfoCellUpdate \(rows)")

        self.updateRows(rows)
    }
}
