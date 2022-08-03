//
//  PictureCollectionViewCell.swift
//  VK App
//
//  Created by Asset Ryskul on 23.12.2021.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var likeButton: SubclassedUIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupButton(isLiked: Bool) {
        if isLiked {
            likeButton.setTitle("1", for: .normal)
            animateLikes("heart.fill")
        } else {
            likeButton.setTitle("0", for: .normal)
            animateLikes("heart")
        }
    }
    
    func animateLikes(_ heart: String) {
        UIView.transition(
            with: likeButton,
            duration: 0.5,
            options: [
                .transitionFlipFromBottom,
            ]) {
                self.likeButton.setImage(UIImage(systemName: heart), for: .normal)
            }
    }

}
