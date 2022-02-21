//
//  PictureCollectionViewController.swift
//  VK App
//
//  Created by Asset Ryskul on 17.12.2021.
//

import UIKit
import SDWebImage

class PictureCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var avaImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var image: String = ""
    var name: String = ""
    var userId: Int = 0
    var photos = [PhotoSizes]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var passedPhotos = [String]()
    var passedCurrentPhoto = ""
    
    private let networkService = NetworkService()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        avaImageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "user1"))
        avaImageView.layer.masksToBounds = true
        avaImageView.layer.cornerRadius = 14.0
        
        nameLabel.text = name
        //photos.append((UIImage(named: "user\(userId)_col1")!, false))
        //photos.append((UIImage(named: "user\(userId)_col2")!, false))
        
        networkService.fetchFriendPhotos("\(userId)") { [weak self] result in
            switch result {
            case .success(let photo):
                self?.photos = photo.response.items
            case .failure(let error):
                print(error)
            }
        }
        
        self.collectionView.register(UINib(nibName: "PictureCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: Constants.pictureCollectionCell)
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.pictureCollectionCell, for: indexPath) as! PictureCollectionViewCell //else { return UICollectionViewCell() }
        cell.pictureImageView.sd_setImage(with: URL(string: photos[indexPath.item].sizes.last!.url), placeholderImage: UIImage(named: "user1"))
        cell.pictureImageView.layer.masksToBounds = true
        cell.pictureImageView.layer.cornerRadius = 12.0
        let likeButton = cell.likeButton!
        likeButton.indexPath = indexPath
        likeButton.indexPath.item = indexPath.item
        likeButton.addTarget(self, action: #selector(likeButton_Pressed), for: .touchUpInside)
        cell.setupButton(isLiked: photos[indexPath.item].like)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        for photo in photos {
            passedPhotos.append(photo.sizes.last!.url)
        }
        passedCurrentPhoto = photos[indexPath.item].sizes.last!.url
        performSegue(withIdentifier: Constants.gogoToPictureBrowser, sender: self)
    }
    
    // MARK: - prepare segue to pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PictureBrowserViewController {
            vc.currentPhoto = passedCurrentPhoto
            vc.photos = passedPhotos
        }
    }
    
    // MARK: - like button pressed method
    @objc func likeButton_Pressed(_ sender: SubclassedUIButton) {
        photos[sender.indexPath.item].like = !photos[sender.indexPath.item].like
        collectionView.reloadItems(at: [sender.indexPath])
    }
    

}
