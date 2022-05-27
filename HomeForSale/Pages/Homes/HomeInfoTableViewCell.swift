//
//  HomeInfoTableViewCell.swift
//  HomeForSale
//
//  Created by Yury Bely on 23.05.2022.
//

import UIKit
import PureLayout

class HomeInfoTableViewCell: UITableViewCell {
    
    let minPadding: CGFloat = 4.0
    let smallPadding: CGFloat = 16.0
    
    
    var viewModel: HomeInfoCellViewModel? {
        didSet {
            updateElements()
        }
    }
    
    private func updateElements() {
        houseImage.image = UIImage(named: "houseImg")
        addressLabel.text = viewModel?.address
        municipalityLabel.text = viewModel?.municipalityArea
        priceLabel.text = String(viewModel?.price ?? 0)
        livingAreaLabel.text = String(viewModel?.livingArea ?? 0)
        numberOfRoomsLabel.text = String(viewModel?.numberOfRooms ?? 0)
        
        setNeedsUpdateConstraints()
    }
    
    lazy var houseImage: UIImageView = {
        let imageView = UIImageView(forAutoLayout: ())
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        return label
    }()
    
    lazy var municipalityLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        label.textColor = .gray
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        label.text = String(viewModel?.price ?? 0)
        return label
    }()
    
    lazy var livingAreaLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        label.text = String(viewModel?.livingArea ?? 0)
        return label
    }()
    
    lazy var numberOfRoomsLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        label.text = String(viewModel?.numberOfRooms ?? 0)
        label.textAlignment = .right
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(houseImage)
        contentView.addSubview(addressLabel)
        contentView.addSubview(municipalityLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(livingAreaLabel)
        contentView.addSubview(numberOfRoomsLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        
        houseImage.autoPinEdge(toSuperviewEdge: .top, withInset: smallPadding)
        houseImage.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        houseImage.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        houseImage.autoSetDimension(.height, toSize: 200)
        
        addressLabel.autoPinEdge(.top, to: .bottom, of: houseImage, withOffset: smallPadding)
        addressLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        addressLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        addressLabel.setContentHuggingPriority(.defaultLow-1, for: .vertical)
        
        municipalityLabel.autoPinEdge(.top, to: .bottom, of: addressLabel, withOffset: minPadding)
        municipalityLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        municipalityLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        

        livingAreaLabel.autoPinEdge(.top, to: .bottom, of: municipalityLabel, withOffset: minPadding)
        livingAreaLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: smallPadding)
        livingAreaLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        priceLabel.autoAlignAxis(.horizontal, toSameAxisOf: livingAreaLabel)
        priceLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        priceLabel.autoPinEdge(.trailing, to: .leading, of: livingAreaLabel, withOffset: smallPadding)
        priceLabel.setContentHuggingPriority(.defaultLow-1, for: .horizontal)

        
        numberOfRoomsLabel.autoAlignAxis(.horizontal, toSameAxisOf: livingAreaLabel)
        numberOfRoomsLabel.autoPinEdge(.leading, to: .trailing, of: livingAreaLabel, withOffset: smallPadding)
        numberOfRoomsLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        numberOfRoomsLabel.setContentHuggingPriority(.defaultLow-1, for: .horizontal)
        
        super.updateConstraints()
    }
}
