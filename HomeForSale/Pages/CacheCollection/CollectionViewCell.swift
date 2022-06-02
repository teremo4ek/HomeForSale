//
//  CollectionViewCell.swift
//  HomeForSale
//
//  Created by Yury Bely on 02.06.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let minPadding: CGFloat = 8.0
    let smallPadding: CGFloat = 16.0

    var viewModel: CollectionCellViewModel? {
        didSet {
            // updateElements()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {

    }

    private func updateElements() {
        print("CollectionViewCell: updateElements")
        setNeedsUpdateConstraints()
    }

}
