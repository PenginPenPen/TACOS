//
//  testStack.swift
//  TACOS
//
//  Created by 疋田朋也 on 2024/08/23.
//

import UIKit

import UIKit
import SwiftUI

class TestStackView: UIViewController {
    private let postStackView = UIStackView()
    private let postView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        setupPostView()
        setupConstraints()
    }

    private func setupConstraints() {
        view.addSubview(postStackView)
        postStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        postView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postView.widthAnchor.constraint(equalTo: postStackView.widthAnchor),
            postView.heightAnchor.constraint(equalToConstant: 100) // 適切な高さを設定
        ])
    }

    private func setupPostView() {
        let label1 = UILabel()
        label1.text = "First Label"
        let button = UIButton(type: .system)
        button.setTitle("Click me", for: .normal)

        postView.addSubview(label1)
        postView.addSubview(button)
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: postView.topAnchor, constant: 8),
            label1.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 8),
            
            button.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 8),
            button.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 8)
        ])
        
        postStackView.addArrangedSubview(postView)
    }

    private func setupStackView() {
        postStackView.axis = .vertical
        postStackView.distribution = .fillEqually
        postStackView.alignment = .center
        postStackView.spacing = 16
    }
}

// プレビュー用のコード
struct TestStackViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TestStackView {
        return TestStackView()
    }
    
    func updateUIViewController(_ uiViewController: TestStackView, context: Context) {}
}

struct TestStackView_Previews: PreviewProvider {
    static var previews: some View {
        TestStackViewRepresentable()
    }
}
#Preview(){
    TestStackView()
}
