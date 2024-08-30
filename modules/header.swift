//
//  header.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/27.
//

import Foundation
import UIKit

protocol CustomHeaderViewDelegate: AnyObject {
    func headerViewDidTapButton(_ headerView: CustomHeaderView)
}

extension UIViewController: CustomHeaderViewDelegate {
    func setupCustomHeader() {
        let headerView = CustomHeaderView()
        headerView.delegate = self
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func headerViewDidTapButton(_ headerView: CustomHeaderView) {
        let  UserProfile = UserProfileViewController()
        self.navigationController?.pushViewController( UserProfile, animated: true)
    }
}

class CustomHeaderView: UIView {
    weak var delegate: CustomHeaderViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ヘッダーだよ"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sample"), for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        self.backgroundColor = AccentColor_gray
        addSubview(titleLabel)
        iconButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(iconButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            iconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            iconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconButton.widthAnchor.constraint(equalToConstant: 32),
            iconButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc private func buttonTapped() {
        delegate?.headerViewDidTapButton(self)
    }
}
