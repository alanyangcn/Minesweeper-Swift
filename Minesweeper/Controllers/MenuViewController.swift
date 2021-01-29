//
//  MenuViewController.swift
//  saolei
//
//  Created by 杨立鹏 on 2021/1/27.
//

import UIKit

class MenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        title = "菜单"

        let titles = ["初级", "中级", "高级"]

        for (index, title) in titles.enumerated() {
            let button = UIButton()

            button.setTitle(title, for: .normal)
            view.addSubview(button)

            button.frame = CGRect(x: (UIScreen.main.bounds.width - 100) * 0.5, y: 200 + CGFloat(index) * 100, width: 100, height: 44)
            button.backgroundColor = .gray
            button.tag = index
            button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        }
    }

    @objc private func buttonClick(button: UIButton) {
        let vc = PlayViewController()
        vc.level = Level(rawValue: button.tag)!
        navigationController?.pushViewController(vc, animated: true)
    }
}
