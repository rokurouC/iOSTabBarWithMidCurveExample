//
//  MidCurveTabBar.swift
//  MidCircleTabBar
//
//  Created by will on 2020/10/21.
//

import UIKit

protocol MidCurveTabBarDelegate: class {
    func midCurveTabBaDidTapMidButton(midCurveTabBar: MidCurveTabBar)
}

class MidCurveTabBar: UITabBar {
    weak var midBarDelegate: MidCurveTabBarDelegate?
    private var shapeLayer: CALayer?
    private var midCurveRadius: CGFloat = 37.0
    private var midCurveCornerRadius: CGFloat = 7.0
    private var midButtonSize: CGSize {
        return .init(width: (self.midCurveRadius - self.midCurveCornerRadius) * 2, height: (self.midCurveRadius - self.midCurveCornerRadius) * 2)
    }
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        //The below 4 lines are for shadow above the bar. you can skip them if you do not want a shadow
        //        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        //        shapeLayer.shadowRadius = 10
        //        shapeLayer.shadowColor = UIColor.gray.cgColor
        //        shapeLayer.shadowOpacity = 0.3
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    override func draw(_ rect: CGRect) {
        addShape()
        addMidButton()
    }
    
    private func createPath() -> CGPath {
        let radius: CGFloat = midCurveRadius
        let cornerRadius: CGFloat = midCurveCornerRadius
        let path = UIBezierPath()
        let centerWidth = frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: (centerWidth - radius - cornerRadius), y: 0))
        
        path.addArc(withCenter: CGPoint(x: (centerWidth - radius - cornerRadius), y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(270).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: true)
        
        path.addArc(withCenter: CGPoint(x: centerWidth, y: cornerRadius), radius: radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: false)
        
        path.addArc(withCenter: CGPoint(x: (centerWidth + radius + cornerRadius), y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(270).degreesToRadians, clockwise: true)
        
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.close()
        
        return path.cgPath
    }
    
    private func addMidButton() {
        let centerWidth = frame.width / 2
        let btn = MidCircleButton(size: midButtonSize, title: "HOME")
        btn.center = CGPoint(x: centerWidth, y: midCurveCornerRadius)
        btn.addTarget(self, action: #selector(midBtnDidTap), for: .touchUpInside)
        self.addSubview(btn)
    }
    
    @objc private func midBtnDidTap() {
        self.midBarDelegate?.midCurveTabBaDidTapMidButton(midCurveTabBar: self)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
