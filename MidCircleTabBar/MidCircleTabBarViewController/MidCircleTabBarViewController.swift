//
//  MidCircleTabBarViewController.swift
//  MidCircleTabBar
//
//  Created by will on 2020/10/21.
//

import UIKit

class MidCircleTabBarViewController: UITabBarController, MidCurveTabBarDelegate {
    private let centerBarItemTag = 999
    func midCurveTabBaDidTapMidButton(midCurveTabBar: MidCurveTabBar) {
        selectedIndex = centerBarItemTag
        let homeVC = HomeViewController()
        self.present(homeVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegate = self
        if let midTabBar = tabBar as? MidCurveTabBar {
            midTabBar.midBarDelegate = self
        }
        viewControllers = [
            genVCExample(withCenterTitle: "VC1", withTabBarSystemItem: .favorites, andTag: 1),
            genVCExample(withCenterTitle: "VC2", withTabBarSystemItem: .recents, andTag: 2),
            genVCExample(withCenterTitle: "VC3", withTabBarSystemItem: nil, andTag: centerBarItemTag),
            genVCExample(withCenterTitle: "VC4", withTabBarSystemItem: .mostViewed, andTag: 4),
            genVCExample(withCenterTitle: "VC5", withTabBarSystemItem: .contacts, andTag: 5)
        ]
    }
    
    private func genVCExample(withCenterTitle title: String, withTabBarSystemItem item: UITabBarItem.SystemItem?, andTag tag:Int) -> UIViewController {
        let vc = UIViewController()
        if let tabBarItem = item {
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: tabBarItem, tag: tag)
        }else {
            vc.tabBarItem = UITabBarItem()
            vc.tabBarItem.tag = tag
        }
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 15)
        vc.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        return vc
    }
}

extension MidCircleTabBarViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard viewController.tabBarItem.tag != centerBarItemTag else {
            return false
        }
        return true
    }
}
