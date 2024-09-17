//
//  footer.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/09/10.
//

import UIKit
protocol FooterDelegate: AnyObject {
    func footerDidTapPlusButton(_ footer: Footer)
    func homefooterDidTapPlusButton(_ footer: Footer)
}
extension UIViewController: FooterDelegate {
    func footerDidTapPlusButton(_ footer: Footer) {
        print("plus tapped")
        let AddPost = AddPostViewController()
        self.navigationController?.pushViewController(AddPost, animated: true)
    }
    func homefooterDidTapPlusButton(_ footer: Footer){
        let TimeLine = TimelineViewController()
        self.navigationController?.pushViewController(TimeLine, animated: true)    }
}
class Footer: UIView {
    weak var delegate: FooterDelegate?  // デリゲートを保持
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let homeButton = UIButton(type: .system)
    private let plusButton = UIButton(type: .system)
    private let notifiButton = UIButton(type: .system)
    private let stepsButton = UIButton(type: .system)
    private func setupButtons() {
        homeButton.setImage(UIImage(systemName: "house"), for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        notifiButton.setImage(UIImage(systemName: "bell"), for: .normal)
        stepsButton.setImage(UIImage(systemName: "figure.step.training"), for: .normal)
        stackView.addArrangedSubview(homeButton)
        stackView.addArrangedSubview(plusButton)
        stackView.addArrangedSubview(notifiButton)
        stackView.addArrangedSubview(stepsButton)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
    }

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        contentView.backgroundColor = AccentColor_gray
        addSubview(contentView)
        contentView.addSubview(stackView)
        setupButtons()
        setupConstraints()
    }

    @objc func plusButtonTapped() {
        delegate?.footerDidTapPlusButton(self)  // デリゲートメソッドを呼び出し
    }
    @objc func homeButtonTapped(){
        delegate?.homefooterDidTapPlusButton(self)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 50),

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
