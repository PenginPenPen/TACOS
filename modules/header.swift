//
//  header.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/27.
//

import Foundation
import UIKit

extension UIViewController {
    func setupCustomHeader() {
        let headerView = CustomHeaderView(frame: .zero)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60) // ヘッダーの高さを適切に調整
        ])
    }
}

class CustomHeaderView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ヘッダーだよ"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "defaultUserIcon"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.0)
        addSubview(titleLabel)
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
