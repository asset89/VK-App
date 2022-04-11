//
//  FrindsTableViewController.swift
//  VK App
//
//  Created by Asset Ryskul on 17.12.2021.
//

import UIKit
import SDWebImage
import RealmSwift

class FriendsTableViewController: UITableViewController {
    
//    var friends = [Friend(id: 1, name: "John Doe", ava: "user1"),
//                   Friend(id: 2, name: "Joanna Lilly", ava: "user2"),
//                   Friend(id: 3, name: "Mo Williams", ava: "user3"),
//                   Friend(id: 4, name: "Sarah Yu", ava: "user4"),
//                   Friend(id: 5, name: "Ivan Ivanov", ava: "user5")]
    private var friends = [Friend]() {
        didSet {
            DispatchQueue.main.async {
                self.sortNames()
                self.tableView.reloadData()
            }
        }
    }
    private var realmFriends: Results<RealmFriend>?
    
    // values for passing another vc
    var passedImage: String?
    var passedName: String?
    var passedId: Int?
    
    var alphabet_tuples = [(String, [String])]()
    
    private let networkService = NetworkService()
    
    fileprivate func reloadFriends() {
        realmFriends = try? RealmService.load(typeOf: RealmFriend.self)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "StandartCell", bundle: nil), forCellReuseIdentifier: Constants.standartCell)
        networkService.fetchFriends() { [weak self] result in
            switch result {
            case .success(let friend):
                self?.friends = friend.response.items
                //let realmFriends = friend.response.items.map { RealmFriend(friend: $0)}
                /*DispatchQueue.main.async {
                    do {
                        try RealmService.save(items: realmFriends)
                        self?.reloadFriends()
                    } catch {
                        print(error)
                    }
                }*/
            case .failure(let error):
                print(error)
            }
        }
        
        //tableView.reloadData()
        
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
        for friend in friends where fullname == friend.lastName {
            cell.usernameLabel.text = friend.lastName + " " + friend.firstName
            let avaImageView = cell.userAvatarImageView!
            avaImageView.sd_setImage(with: URL(string: friend.photo200orig), placeholderImage: UIImage(named: "user1"))
            //cell.userAvatarImageView.image = UIImage(named: friend.ava)
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
        for friend in friends where fullname == friend.lastName {
            passedImage = friend.photo200orig
            passedName = friend.lastName + " " + friend.firstName
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
            let name = friend.lastName
            names.append(name)
        }
        for name in names {
            let letter = name.first
            alphabet_tuples.append((String(letter!), names.filter({ $0.contains(letter!)})))
        }
        alphabet_tuples.sort {$0.0 < $1.0}
    }
}
