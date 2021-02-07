//
//  MenuViewController.swift
//  saolei
//
//  Created by 杨立鹏 on 2021/1/27.
//

import SnapKit
import UIKit
class MenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        navigationController?.setNavigationBarHidden(true, animated: false)

        title = "菜单"

        let bgImageView = UIImageView(image: UIImage(named: "bg"))

        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let titles = ["初级", "中级", "高级"]

        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .custom)

            button.setTitle(title, for: .normal)
            view.addSubview(button)

            button.backgroundColor = .gray
            button.tag = index
            button.setBackgroundImage(UIImage(named: "icon_button_bg"), for: .normal)
            button.setBackgroundImage(UIImage(named: "icon_button_bg"), for: .highlighted)
            button.setTitleColor(#colorLiteral(red: 0.6597810984, green: 0.9653044343, blue: 0.01802068204, alpha: 1), for: .normal)
            button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalTo(260)
                make.height.equalTo(55)
                make.top.equalToSuperview().offset(200 + index * 100)
            }
        }
    }

    @objc private func buttonClick(button: UIButton) {
        let vc = PlayViewController()
        vc.level = Level(rawValue: button.tag)!
        navigationController?.pushViewController(vc, animated: true)
    }
}
