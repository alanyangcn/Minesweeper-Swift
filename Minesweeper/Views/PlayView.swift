//
//  PlayView.swift
//  saolei
//
//  Created by 杨立鹏 on 2021/1/26.
//

import UIKit

class PlayView: UIView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    private func setupUI() {
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = 2.0
        let rowWidth = (frame.size.width - margin * CGFloat(level.column - 1)) / CGFloat(level.column)
        let rowHeight = (frame.size.height - margin * CGFloat(level.row - 1)) / CGFloat(level.row)

        let sideLength = max(min(rowWidth, rowHeight), 60)
        let left = (frame.size.width - sideLength * CGFloat(level.column) - margin * CGFloat(level.row - 1)) * 0.5
        let top = (frame.size.height - sideLength * CGFloat(level.row) - margin * CGFloat(level.row - 1)) * 0.5
        
        for i in 0 ..< level.row {
            for j in 0 ..< level.column {
                let button = cubes[level.row * i + j]
                button.frame = CGRect(x: left + CGFloat(j) * (sideLength + margin), y: top + CGFloat(i) * (sideLength + margin), width: sideLength, height: sideLength)
               
            }
        }
        
        
    }

    var gameOverCallback: (() -> Void)?

    var isPlaying = false
    var startIndex = 0
    var nums = [Int]()
    var level = Level.junior

    var cubes = [Cube]()

    func start(level: Level) {
        cubes = []
        subviews.forEach({ $0.removeFromSuperview() })
        startIndex = 0
        nums = []

        isPlaying = false
        self.level = level

        
        var tag = 0
        for i in 0 ..< level.row {
            for j in 0 ..< level.column {
                let button = Cube()

                button.layer.borderColor = UIColor.darkGray.cgColor
                button.layer.borderWidth = 2
                addSubview(button)
                button.contentValue = "☁️"
                
                button.tag = tag
                button.rowIndex = i
                button.colunmIndex = j
                button.addTarget(self, action: #selector(tap), for: .touchUpInside)

                let longGes = UILongPressGestureRecognizer(target: self, action: #selector(longTap(ges:)))
                button.addGestureRecognizer(longGes)
                tag += 1
                cubes.append(button)
            }
        }
    }

    @objc private func longTap(ges: UILongPressGestureRecognizer) {
        print("--------\(ges.state.rawValue)-------")
        if ges.state == .began, let cube = ges.view as? Cube {
            cube.isFlag = true
        }
    }

    /// 点击事件
    @objc private func tap(cube: Cube) {
        if cube.isFlag {
            return
        }
        if cube.isBomb {
            print("Game Over")
            cubes.forEach({ if $0.isBomb { $0.contentValue = "💣" }})

            gameOverCallback?()
            return
        }
        if isPlaying {
            refresh(by: cube.tag)
        } else {
            isPlaying = true
            startIndex = cube.tag
            setBombs()
        }
    }

    /// 放置地雷
    private func setBombs() {
        getNums()
        for i in nums {
            cubes[i].isBomb = true
        }

        refresh(by: startIndex)
    }

    private func refresh(by index: Int) {
        let cube = cubes[index]

        setNumbers(colunm: cube.colunmIndex, row: cube.rowIndex)
    }

    private func setNumbers(colunm: Int, row: Int) {
        let num = getCountAround(colunm: colunm, row: row)
        let index = row * level.column + colunm
        let cube = cubes[index]

        if num > 0 {
            cube.contentValue = "\(num)"
        } else {
            if cube.contentValue != "" {
                cube.contentValue = ""
                for i in max(0, colunm - 1) ..< min(colunm + 2, level.column) {
                    for j in max(0, row - 1) ..< min(row + 2, level.row) {
                        debugPrint("\(i)-\(j)")

                        setNumbers(colunm: i, row: j)
                    }
                }
            }
        }
    }

    private func getCountAround(colunm: Int, row: Int) -> Int {
        var count = 0
        for i in max(0, colunm - 1) ..< min(colunm + 2, level.column) {
            for j in max(0, row - 1) ..< min(row + 2, level.row) {
                let index = j * level.column + i
                let cube = cubes[index]
                if cube.isBomb {
                    count += 1
                }
            }
        }

        return count
    }

    private func getNums() {
        print(nums.count)
        if nums.count == level.bombCount {
            return
        }
        let buttonsCount = cubes.count
        let num = Int(arc4random() % UInt32(buttonsCount))

        if nums.firstIndex(of: num) == nil, !isNumRoundStartIndex(num: num) {
            nums.append(num)
        }

        getNums()
    }

    /// 判断当前索引的按钮是否在初始按钮的周围
    /// - Parameter num: 索引
    /// - Returns: 是否
    private func isNumRoundStartIndex(num: Int) -> Bool {
        let startCube = cubes[startIndex]
        let cube = cubes[num]

        if abs(cube.rowIndex - startCube.rowIndex) <= 1 && abs(cube.colunmIndex - startCube.colunmIndex) <= 1 {
            return true
        }

        return false
    }
}

class Cube: UIButton {
    var rowIndex = 0

    var colunmIndex = 0

    var contentValue: String = "" {
        didSet {
            setTitle(contentValue, for: .normal)
        }
    }

    var isBomb = false

    var isFlag = false {
        didSet {
            if isFlag {
                setTitle("🇨🇳", for: .normal)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    private func setupUI() {
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
