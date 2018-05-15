//
//  PagingVC.swift
//  Salaat
//
//  Created by Karthick on 5/15/18.
//  Copyright © 2018 Karthick. All rights reserved.
//

import UIKit

class PagingVC: UIViewController,UIScrollViewDelegate
{
  let imagelist = ["1.jpg", "2.jpg", "3.jpg", "4.jpg"]
  var scrollView = UIScrollView()
  var pageControl : UIPageControl = UIPageControl()
  var screenWidth = CGFloat()
  var screenHeight = CGFloat()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.isNavigationBarHidden = true
    screenHeight = self.view.frame.size.height
    screenWidth = self.view.frame.size.width
    
    scrollView = UIScrollView(frame: CGRect(x: 0, y: -20, width: screenWidth, height: screenHeight+20))
    pageControl = UIPageControl(frame: CGRect(x: screenWidth/2-screenWidth/4, y: screenHeight-100, width: screenWidth/2, height: 50))
    scrollView.delegate = self
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.bounces = false
    self.view.addSubview(scrollView)
    configurePageControl()
    for  i in stride(from: 0, to: imagelist.count, by: 1) {
      self.scrollView.isPagingEnabled = true
      let myImage:UIImage = UIImage(named: imagelist[i])!
      let myImageView:UIImageView = UIImageView()
      myImageView.image = myImage
     // myImageView.contentMode = UIViewContentMode.scaleAspectFit
      myImageView.frame = CGRect(x: self.scrollView.frame.size.width * CGFloat(i), y: 0, width: screenWidth, height: screenHeight)
      scrollView.addSubview(myImageView)
    }
    self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(imagelist.count), height: screenHeight-20)
    pageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)
  }
  
  func configurePageControl() {
    self.pageControl.numberOfPages = imagelist.count
    self.pageControl.currentPage = 0
    self.pageControl.tintColor = UIColor.red
    self.pageControl.pageIndicatorTintColor = UIColor.black
    self.pageControl.currentPageIndicatorTintColor = UIColor.green
    self.view.addSubview(pageControl)
  }
  
  // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
  func changePage(sender: AnyObject) -> () {
    let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
    scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
    pageControl.currentPage = Int(pageNumber)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
