//
//  PinchZoomViewController.swift
//  PinchZoom
//
//  Created by Kalyan Vishnubhatla on 12/26/17.
//  Copyright © 2017 Kalyan Vishnubhatla. All rights reserved.
//

import UIKit

class PinchZoomViewController: UIViewController, UIScrollViewDelegate {

    let image: UIImage!
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.image = UIImage()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.scrollView = self.createScrollView()
        self.view.addSubview(self.scrollView)
        
        self.imageView = self.createImageView()
        self.scrollView.addSubview(self.imageView)
        
        self.setMaxMinZoomScalesForCurrentBounds()
    }
    
    func createImageView() -> UIImageView {
        let imageView : UIImageView = UIImageView(image: self.image)
        imageView.frame =  CGRect(x: 0, y: 0, width: self.image.size.width, height: self.image.size.height)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(white: 0, alpha: 1)
        
        return imageView
    }
    
    func createScrollView() -> UIScrollView {
        let sv = UIScrollView(frame: self.view.bounds)
        sv.delegate = self
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.decelerationRate = UIScrollViewDecelerationRateFast
        sv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return sv
    }
    
    func setMaxMinZoomScalesForCurrentBounds() {
        let boundsSize = self.scrollView.bounds.size
        let imageSize = self.imageView.frame.size
        
        // Calculate Min
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)

        // Calculate Max
        let maxScale: CGFloat = 4.0
        
        // Apply zoom
        self.scrollView.maximumZoomScale = maxScale
        self.scrollView.minimumZoomScale = minScale
        self.scrollView.zoomScale = minScale
    }
    
    // ScrollView Delegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.scrollView.subviews.first
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerScrollViewContents()
    }
    
    func centerScrollViewContents() {
        let boundsSize = self.scrollView.bounds.size
        var contentsFrame = self.imageView.frame
        
        if (contentsFrame.size.width < boundsSize.width) {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if (contentsFrame.size.height < boundsSize.height) {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        self.imageView.frame = contentsFrame
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
