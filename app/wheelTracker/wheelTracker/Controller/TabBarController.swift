//
//  TabBarController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/04/30.
//
//  첫 화면 로딩 시 선택 된 화면이 홈 화면이 되도록 함.

import UIKit
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
        // Do any additional setup after loading the view.
    }

}
