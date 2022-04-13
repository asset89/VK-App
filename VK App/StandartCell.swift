//
//  StandartCell.swift
//  VK App
//
//  Created by Asset Ryskul on 22.12.2021.
//

import UIKit

class StandartCell: UITableViewCell {

    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBInspectable var shadowOpacity: Float = 0.4 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 10.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutIfNeeded() {
        configureShadow()
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(onTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        
        avatarView.layer.cornerRadius = avatarView.frame.height / 2
        avatarView.addGestureRecognizer(tapGestureRecognizer)
        userAvatarImageView.layer.cornerRadius = userAvatarImageView.frame.height / 2
        userAvatarImageView.layer.masksToBounds = true

        
    }
    
    func configureShadow() {
        avatarView.layer.shadowColor = UIColor.green.cgColor
        avatarView.layer.shadowOpacity = shadowOpacity
        avatarView.layer.shadowOffset = shadowOffset
        avatarView.layer.shadowRadius = shadowRadius
    }
    
    @objc func onTap() {
        animateImageView()
    }
    
    func animateImageView() {
 
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            usingSpringWithDamping: 0.1,
            initialSpringVelocity: 1.0) {
                self.avatarView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            } completion: { _ in
                self.avatarView.transform = .identity
            }
    }

}
