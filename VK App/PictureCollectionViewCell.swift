//
//  PictureCollectionViewCell.swift
//  VK App
//
//  Created by Asset Ryskul on 23.12.2021.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupButton(isLiked: Bool) {
        if isLiked {
            likeButton.setTitle("1", for: .normal)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setTitle("0", for: .normal)
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

}
