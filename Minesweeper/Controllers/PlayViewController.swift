//
//  ViewController.swift
//  saolei
//
//  Created by 杨立鹏 on 2021/1/26.
//

import UIKit
import SnapKit
class PlayViewController: UIViewController {
    let playView = PlayView()
    var level = Level.middle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(playView)
        let margin: CGFloat = 8
        playView.backgroundColor = .lightGray

        playView.start(level: level)

        playView.gameOverCallback = { [weak self] in
            self?.gameOverAlert()
        }
        
        playView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }

    private func gameOverAlert() {
        let alertController = UIAlertController(title: "Game Over", message: "胜败乃兵家常事，少侠请从头再来", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "重新开始", style: .default, handler: { _ in
            self.playView.start(level: self.level)
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alertController, animated: true, completion: nil)
    }
}
