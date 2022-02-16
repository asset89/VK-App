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
    
    // values for passing another vc
    var passedImage: UIImage?
    var passedName: String?
    var passedId: Int?
    
    var alphabet_tuples = [(String, [String])]()
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "StandartCell", bundle: nil), forCellReuseIdentifier: Constants.standartCell)
        networkService.fetchFriends()
        sortNames()
        tableView.reloadData()
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return alphabet_tuples.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return alphabet_tuples[section].0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alphabet_tuples[section].1.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.standartCell, for: indexPath) as?
                StandartCell else {
                    return UITableViewCell()
                }
        let fullname = alphabet_tuples[indexPath.section].1[indexPath.row]
        for friend in friends where fullname == friend.name {
            cell.usernameLabel.text = friend.name
            cell.userAvatarImageView.image = UIImage(named: friend.ava)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let fullname = alphabet_tuples[indexPath.section].1[indexPath.row]
        for friend in friends where fullname == friend.name {
            passedImage = UIImage(named: friend.ava)
            passedName = friend.name
            passedId = friend.id
        }
        performSegue(withIdentifier: Constants.goToCollectionSegue, sender: self)
    }
    
    // MARK: - prepare segue to pass data 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PictureCollectionViewController {
            vc.image = passedImage!
            vc.name = passedName!
            vc.userId = passedId!
        }
    }
    
    // MARK: - sort in alphabetical order in section with first letter of lastname
    func sortNames() {
        var names = [String]()
        for friend in friends {
            let name = friend.name
            names.append(name)
        }
        for name in names {
            let nameFormatter = PersonNameComponentsFormatter()
            if let nameComps = nameFormatter.personNameComponents(from: name), let firstLetter = nameComps.familyName?.first {
                let letter = String(firstLetter)
                alphabet_tuples.append((letter, names.filter({ $0.contains(nameComps.familyName!)})))
            }
        }
        alphabet_tuples.sort {$0.0 < $1.0}
    }
}
