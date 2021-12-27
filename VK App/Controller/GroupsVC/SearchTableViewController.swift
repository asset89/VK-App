//
//  SearchTableViewController.swift
//  VK App
//
//  Created by Asset Ryskul on 17.12.2021.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    let another_groups = [
        Group(id: 3, name: "Science", ava: "book.fill"),
        Group(id: 4, name: "Apple Society", ava: "applelogo"),
        Group(id: 5,name: "Fashion 2022", ava: "person.2.fill"),
        Group(id: 6, name: "Autoclub", ava: "car.2.fill")
    ]
    
    var delegate: PassGroupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "StandartCell", bundle: nil), forCellReuseIdentifier: Constants.standartCell)
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return another_groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.standartCell, for: indexPath) as?
                StandartCell else {
                    return UITableViewCell()
                }
        cell.usernameLabel.text = another_groups[indexPath.row].name
        cell.userAvatarImageView.image = UIImage(systemName: another_groups[indexPath.row].ava)
        cell.userAvatarImageView.clipsToBounds = true
        cell.userAvatarImageView.layer.cornerRadius = 6.0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        self.delegate!.passGroup(group: another_groups[indexPath.row])
        navigationController?.popToRootViewController(animated: true)
    }

}
