//
//  GroupsTableViewController.swift
//  VK App
//
//  Created by Asset Ryskul on 17.12.2021.
//

import UIKit

protocol PassGroupProtocol {
    func passGroup(group: Group)
}

class GroupsTableViewController: UITableViewController, PassGroupProtocol {
    
    var groups = [Group(id: 0, name: "Kinoman", ava: "film.fill"),
                  Group(id: 1, name: "Music", ava: "music.note.house.fill"),
                  Group(id: 2, name: "Developers", ava: "keyboard.chevron.compact.down")]
    
    private let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.fetchGroups()
        
        tableView.register(UINib(nibName: "StandartCell", bundle: nil), forCellReuseIdentifier: Constants.standartCell)

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.standartCell, for: indexPath) as?
                StandartCell else {
                    return UITableViewCell()
                }
        cell.usernameLabel.text = groups[indexPath.row].name
        cell.userAvatarImageView.image = UIImage(systemName: groups[indexPath.row].ava)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func passGroup(group: Group) {
        groups.append(group)
        tableView.reloadData()
    }
    
    // MARK: - prepare segue to pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SearchTableViewController {
            vc.delegate = self
        }
    }
    
    
 
}
