//
//  PictureCollectionViewController.swift
//  VK App
//
//  Created by Asset Ryskul on 17.12.2021.
//

import UIKit

class PictureCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var avaImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var image = UIImage()
    var name: String = ""
    var userId: Int = 0
    var photos: [(UIImage, Bool)] = []
    var isUserLiked: Bool = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        avaImageView.image = image
        avaImageView.layer.masksToBounds = true
        avaImageView.layer.cornerRadius = 14.0
        
        nameLabel.text = name
        photos.append((UIImage(named: "user\(userId)_col1")!, isUserLiked))
        photos.append((UIImage(named: "user\(userId)_col2")!, isUserLiked))
        
        self.collectionView.register(UINib(nibName: "PictureCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: Constants.pictureCollectionCell)
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.pictureCollectionCell, for: indexPath) as! PictureCollectionViewCell //else { return UICollectionViewCell() }
        
        cell.setupButton(isLiked: photos[indexPath.item].1)
        cell.pictureImageView.image = photos[indexPath.item].0
        cell.pictureImageView.layer.masksToBounds = true
        cell.pictureImageView.layer.cornerRadius = 12.0
        let likeButton = cell.likeButton!
        likeButton.tag = indexPath.item
        likeButton.addTarget(self, action: #selector(likeButton_Pressed), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func likeButton_Pressed(_ sender: UIButton) {
        isUserLiked = !isUserLiked
        photos[sender.tag].1 = isUserLiked
        collectionView.reloadData()
    }

}
