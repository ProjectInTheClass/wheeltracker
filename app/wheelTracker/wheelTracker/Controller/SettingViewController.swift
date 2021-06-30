//
//  SettingViewController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/04/30.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var zeroing: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        do{
            try print(ProfileDataStore.getAge())
        }catch{

        }
        // Do any additional setup after loading the view.
    }
}
