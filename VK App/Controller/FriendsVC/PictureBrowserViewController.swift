//
//  PictureBrowserViewController.swift
//  VK App
//
//  Created by Asset Ryskul on 27.01.2022.
//

import UIKit
import SDWebImage

class PictureBrowserViewController: UIViewController {

    @IBOutlet weak var browserImageView: UIImageView!
    
    var currentPhoto = ""
    var photos: [String] = []
    var currentImage = 0
    
    private let duration = 2.0
    private let delay = 0.3
    
    private var propertyAnimator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        browserImageView.sd_setImage(with: URL(string: currentPhoto), placeholderImage: UIImage(named: "user1"))
        for (index, photo) in photos.enumerated(){
            if photo == currentPhoto {
                currentImage = index
            }
        }
        
        browserImageView.isUserInteractionEnabled = true
        browserImageView.addGestureRecognizer(UIPanGestureRecognizer(
            target: self,
            action: #selector(didPan(_:))))
        
    }
    
    @objc
    private func didPan(_ gesture: UIPanGestureRecognizer) {
        
        /*switch gesture.direction {
        case .left where currentImage == 0:
            propertyAnimator = UIViewPropertyAnimator(
                duration: duration,
                curve: .easeInOut,
                animations: {
                    let transform = CGAffineTransform(translationX: self.browserImageView.frame.width, y: 0.0)
                    self.browserImageView.transform = transform
                    self.browserImageView.image = self.photos[self.currentImage + 1]
                })
            propertyAnimator.pauseAnimation()
            propertyAnimator.continueAnimation(
                withTimingParameters: nil,
                durationFactor: 0)
        case .right where currentImage == 1:
            propertyAnimator = UIViewPropertyAnimator(
                duration: duration,
                curve: .easeInOut,
                animations: {
                    let transform = CGAffineTransform(translationX: self.browserImageView.frame.width, y: 0.0)
                    self.browserImageView.transform = transform
                    self.browserImageView.image = self.photos[self.currentImage - 1]
                })
            propertyAnimator.pauseAnimation()
            propertyAnimator.continueAnimation(
                withTimingParameters: nil,
                durationFactor: 0)
        default:
            return
        }*/
        
        
        
        switch gesture.state {
        case .began:
            propertyAnimator = UIViewPropertyAnimator(
                duration: duration,
                curve: .easeInOut,
                animations: {
                    let transform = CGAffineTransform(translationX: self.browserImageView.frame.width, y: 0.0)
                    self.browserImageView.transform = transform
                })
            
            propertyAnimator.pauseAnimation()
        case .changed:

            if currentImage == 0 {
                self.browserImageView.sd_setImage(with: URL(string: self.photos[self.currentImage + 1]), placeholderImage: UIImage(named: "user1"))
            } else {
                self.browserImageView.sd_setImage(with: URL(string: self.photos[self.currentImage - 1]), placeholderImage: UIImage(named: "user1"))
            }
            
        case .ended:
            if propertyAnimator.fractionComplete > 0.5 {
                propertyAnimator.continueAnimation(
                    withTimingParameters: nil,
                    durationFactor: 0)
            } else {
                propertyAnimator.pauseAnimation()
               //propertyAnimator.stopAnimation(true)
                //propertyAnimator.finishAnimation(at: .current)
            }
            
        default:
            return
        }
    }
    

    

    


}
