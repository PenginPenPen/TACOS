//
//  TestViewController.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/27.
//


import UIKit
class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // カスタムヘッダービューを作成
        let headerView = CustomHeaderView(frame: .zero)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)

        // Auto Layoutを使用してヘッダービューを画面の上部に固定
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80) // ヘッダーの高さを指定
        ])
    }
}
class CCustomHeaderView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "defaultUserIcon"))
        imageView.contentMode = .scaleAspectFit
//        imageView.r
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
        self.backgroundColor =  UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1.0)
        addSubview(titleLabel)
        addSubview(iconImageView)
        
        // Auto LayoutでtitleLabelを中央に配置
        NSLayoutConstraint.activate([
            // タイトルラベルの制約は右側に少しずらします
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -40), // 調整値を必要に応じて変更
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            // 画像ビューの制約
            iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16), // 16はヘッダーからの余白
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 32), // 画像のサイズを調整
            iconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}


#Preview(){
    TestViewController()
}
