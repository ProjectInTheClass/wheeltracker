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
    var nowDistance = pushDatas[pushDatas.count-1].distance
    
    
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
        distanceEvent.listenTo(eventName: "distance", action: self.manageDistance)
    }
    
    
    func manageDistance(){
        nowDistance = pushDatas[pushDatas.count-1].distance
        zeroing.text = String(Int(nowDistance-startDistance)) + "m"
        zeroing.font = zeroing.font.withSize(50)
        if(nowDistance - startDistance >= 20){
            let alert = UIAlertController(title: "측정 완료", message: "몇번 밀었나요?", preferredStyle: .alert)

            let ok = UIAlertAction(title: "입력", style: .default) { (ok) in
                let countOfPush = alert.textFields?[0].text
                let cop = countOfPush!
                let cop2 = Int(cop)!
                unitDistance = Double(20)/Double(cop2)
                print(unitDistance)
            }

            let cancel = UIAlertAction(title: "재측정", style: .cancel) { (cancel) in
    
            }

            alert.addAction(ok)
            alert.addAction(cancel)
            alert.addTextField{(mytextField) in
                mytextField.placeholder = "숫자만 입력해주세요."
            }
            
            self.present(alert, animated: true, completion: nil)
            distanceEvent.removeListeners(eventNameToRemoveOrNil: "distance")
        }
    }
    
}
