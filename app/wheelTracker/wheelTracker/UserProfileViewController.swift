//
//  SettingViewController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/04/30.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var wheelsizeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightLabel.text = String(height)+" cm"
        weightLabel.text = String(weight)+" kg"
        wheelsizeLabel.text = String(wheelSize)+" inch"
        
        
        do{
            try print(ProfileDataStore.getAge())
        }catch{

        }
        // Do any additional setup after loading the view.
    }
}
