//
//  LaunchViewController.swift
//  VK App
//
//  Created by Asset Ryskul on 24.01.2022.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    private let duration = 0.9
    private let delay = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
    }
    
    func animate() {
        view.layoutIfNeeded()
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: [
                .curveEaseInOut,
                .repeat,
                .autoreverse
            ]) {
                self.imageView1.alpha = 0.0
                self.view.layoutIfNeeded()
            } completion: { isCompleted in
                self.imageView1.alpha = 1.0
                self.view.layoutIfNeeded()
            }
        UIView.animate(
            withDuration: duration,
            delay: delay + 0.2,
            options: [
                .curveEaseInOut,
                .repeat,
                .autoreverse
            ]) {
                self.imageView2.alpha = 0.0
                self.view.layoutIfNeeded()
            } completion: { isCompleted in
                self.imageView2.alpha = 1.0
                self.view.layoutIfNeeded()
            }
        UIView.animate(
            withDuration: duration,
            delay: delay + 0.4,
            options: [
                .curveEaseInOut,
            ]) {
                self.imageView3.alpha = 0.0
                self.view.layoutIfNeeded()
            } completion: { isCompleted in
                self.imageView3.alpha = 1.0
                self.view.layoutIfNeeded()
                self.performSegue(withIdentifier: Constants.goToLoginSegue, sender: self)
                
            }
    }
    



}
