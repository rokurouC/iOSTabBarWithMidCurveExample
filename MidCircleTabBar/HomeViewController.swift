//
//  HomeViewController.swift
//  MidCircleTabBar
//
//  Created by will on 2020/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        let label = UILabel()
        label.text = "Home"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let closeButton = UIButton(type: .custom)
        closeButton.addTarget(self, action: #selector(closeBtnDidTap), for: .touchUpInside)
        closeButton.setTitle("LEAVE", for: .normal)
        closeButton.setTitleColor(.gray, for: .normal)
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15).isActive = true
    }
    
    @objc private func closeBtnDidTap() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
