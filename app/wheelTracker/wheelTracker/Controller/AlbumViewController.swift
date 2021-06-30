//
//  SettingViewController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/04/30.
//

import UIKit

class AlbumViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var monthLabel: UILabel!
    let albumImageViews = [UIImageView(image: UIImage(named: "album1")), UIImageView(image: UIImage(named: "album2")), UIImageView(image: UIImage(named: "album3"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        addContenScrollView()
        setPageControl()
    }
    
    
    func addContenScrollView() {
        scrollView.frame = CGRect(x: 0, y: self.view.frame.height*CGFloat(0.3), width: self.view.frame.width, height: self.view.frame.height * CGFloat(0.45))
        for i in 0..<albumImageViews.count {
            let xPos = self.view.frame.width * CGFloat(i)
            albumImageViews[i].frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            scrollView.addSubview(albumImageViews[i])
            scrollView.contentSize.width = albumImageViews[i].frame.width * CGFloat(i + 1)
        }
    }
    
    
    func setPageControl() {
        pageControl.numberOfPages = albumImageViews.count
    }
    
    
    func setPageControlSelectedPage(currentPage:Int) {
        monthLabel.text = String(currentPage+3) + " 월"
        pageControl.currentPage = currentPage
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
