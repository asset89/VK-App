//
//  FrindsTableViewController.swift
//  VK App
//
//  Created by Asset Ryskul on 17.12.2021.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    var friends = [Friend(id: 1, name: "John Doe", ava: "user1"),
                   Friend(id: 2, name: "Joanna Lilly", ava: "user2"),
                   Friend(id: 3, name: "Mo Williams", ava: "user3"),
                   Friend(id: 4, name: "Sarah Yu", ava: "user4"),
                   Friend(id: 5, name: "Ivan Ivanov", ava: "user5")]
    
    
    var passedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "StandartCell", bundle: nil), forCellReuseIdentifier: Constants.standartCell)

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.standartCell, for: indexPath) as?
                StandartCell else {
                    return UITableViewCell()
                }
        cell.usernameLabel.text = friends[indexPath.row].name
        cell.userAvatarImageView.image = UIImage(named: friends[indexPath.row].ava)
        cell.userAvatarImageView.layer.masksToBounds = true
        cell.userAvatarImageView.layer.cornerRadius = cell.userAvatarImageView.frame.height / 2
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        passedImage = UIImage(named: friends[indexPath.row].ava)
        performSegue(withIdentifier: Constants.goToCollectionSegue, sender: self)
    }
    
    // MARK: - prepare segue to pass data 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PictureCollectionViewController {
            vc.image = passedImage
        }
    }

}
