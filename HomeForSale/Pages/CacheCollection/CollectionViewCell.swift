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
            viewModel?.delegate = self
            updateElements()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green

        contentView.addSubview(image)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var image: UIImageView = {
        let imageView = UIImageView(forAutoLayout: ())
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override func updateConstraints() {
        // print("CollectionViewCell: updateConstraints")
        image.autoPinEdgesToSuperviewEdges()

        super.updateConstraints()
    }

    private func updateElements() {
        // print("CollectionViewCell: updateElements \(String(describing: viewModel?.photoID))")

        // image.image = viewModel?.thumbnail ??  UIImage(named: "houseImg")
        image.image = viewModel?.largeImage ??  UIImage(systemName: "doc")

        setNeedsUpdateConstraints()
    }
}

// MARK: extension NetworkDataDelegate
extension CollectionViewCell: NetworkDataDelegate {
    func onComplition() {

    }

    func onHomeInfoCellUpdated(indexes: [Int]) {

    }

    func onImageDownloaded(id: String) {
        // print("CollectionViewCell.onImageDownloaded \(id)")
        DispatchQueue.main.async { [weak self] in
            self?.updateElements()
        }
    }

}
