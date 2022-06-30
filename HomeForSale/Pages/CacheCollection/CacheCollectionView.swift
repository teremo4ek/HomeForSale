//
//  CacheCollectionView.swift
//  HomeForSale
//
//  Created by Yury Bely on 02.06.2022.
//

import Foundation
import UIKit

class CacheCollectionView: UIView {

    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.allowsSelection = true
        return collection
    }()

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            print("CacheCollectionView - updateCollectionView()")
            self?.collectionView.reloadData()
        }
    }

    private func addSubviews() {
        addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.autoPinEdgesToSuperviewEdges()

    }
}
