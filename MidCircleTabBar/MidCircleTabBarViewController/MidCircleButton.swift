//
//  MidCircleButton.swift
//  MidCircleTabBar
//
//  Created by will on 2020/10/21.
//

import UIKit

class MidCircleButton: UIButton {
    init(size: CGSize, title: String) {
        super.init(frame: .zero)
        backgroundColor = .lightGray
        frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = size.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
