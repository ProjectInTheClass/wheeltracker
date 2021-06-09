//
//  ZeroingViewController.swift
//  wheeltracker
//
//  Created by 여충관 on 2021/06/10.
//

import UIKit

class ZeroingViewController: UIViewController {

    @IBOutlet weak var zeroing: UILabel!
    @IBOutlet weak var start: UIButton!
    
    var startDistance = pushDatas[pushDatas.count-1].distance
    var nowDistance = pushDatas[pushDatas.count-1].distance {didSet{manageDistance()}}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zeroing.numberOfLines = 0
        zeroing.lineBreakMode = .byWordWrapping
        zeroing.text = "지금부터 20미터 측정을 시작하겠습니다. 측정시작버튼을 누르고 휠체어를 밀면 됩니다."
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func start(_ sender: Any) {
        startDistance = pushDatas[pushDatas.count-1].distance
        nowDistance = pushDatas[pushDatas.count-1].distance
        
    }
    
    
    func manageDistance(){
        zeroing.text = String(Int(nowDistance-startDistance))
    }
    
}
