//
//  DetailScreenViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 19.05.2022.
//

import Foundation
import UIKit

final class DetailScreenViewController: UIViewController {
    var viewModel: DetailScreenViewModel!

    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var livingAreaLabel: UILabel!
    private var livingAreaTitle: UILabel!
    private var livingAreaEnd: UILabel!
    private var loginButton: UIButton!
    private var nameTextField: UITextField!

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .red
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .green
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        navigationItem.title = "Detail Page!"

        let image = UIImage(systemName: "homekit")
        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .cyan
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        titleLabel = UILabel(frame: .zero)
        titleLabel.text = viewModel.title
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.text = viewModel.description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)

        livingAreaLabel = UILabel(frame: .zero)
        livingAreaLabel.text = viewModel.livingAreaLable
        livingAreaLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(livingAreaLabel)

        livingAreaTitle = UILabel(frame: .zero)
        livingAreaTitle.text = viewModel.livingAreaTitle
        livingAreaTitle.font = .boldSystemFont(ofSize: 16)
        livingAreaTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(livingAreaTitle)

        livingAreaEnd = UILabel(frame: .zero)
        livingAreaEnd.text = "end"
        livingAreaEnd.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(livingAreaEnd)

        loginButton = UIButton(type: .system)
        loginButton.setTitle("OK!", for: .normal)
        loginButton.backgroundColor = .darkGray
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(handleLoginTouchUpInside), for: .touchUpInside)

        nameTextField = UITextField(frame: .zero)
        nameTextField.placeholder = "Name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)

        constraintsInit()

        // configureSubviews()
        // setupConstraints()
    }

    func constraintsInit() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 400.0),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),

            livingAreaTitle.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            livingAreaTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            livingAreaTitle.trailingAnchor.constraint(equalTo: livingAreaLabel.leadingAnchor, constant: -10),

            livingAreaLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            livingAreaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            livingAreaEnd.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            livingAreaEnd.leadingAnchor.constraint(equalTo: livingAreaLabel.trailingAnchor, constant: 10),
            livingAreaEnd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            loginButton.topAnchor.constraint(equalTo: livingAreaTitle.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(greaterThanOrEqualTo: nameTextField.leadingAnchor, constant: -10),

            nameTextField.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 200.0),
            nameTextField.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20)
        ])

        livingAreaLabel.setContentHuggingPriority(.defaultLow-1, for: .horizontal)
    }

    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)

        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview( descriptionLabel)
        mainStackView.addArrangedSubview(livingAreaLabel)
        mainStackView.addArrangedSubview(livingAreaTitle)
        mainStackView.addArrangedSubview(livingAreaEnd)
        mainStackView.addArrangedSubview(loginButton)
        mainStackView.addArrangedSubview(nameTextField)

    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
    }

    @objc func handleLoginTouchUpInside() {
        print("Login has been tapped")
        if nameTextField.isFirstResponder {
            nameTextField.resignFirstResponder()
        }
    }
}
