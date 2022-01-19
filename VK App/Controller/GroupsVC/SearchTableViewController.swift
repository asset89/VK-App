//
//  SearchTableViewController.swift
//  VK App
//
//  Created by Asset Ryskul on 17.12.2021.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let another_groups = [
        Group(id: 3, name: "Science", ava: "book.fill"),
        Group(id: 4, name: "Apple Society", ava: "applelogo"),
        Group(id: 5,name: "Fashion 2022", ava: "person.2.fill"),
        Group(id: 6, name: "Autoclub", ava: "car.2.fill")
    ]
    
    var filteredData: [Group]!
    
    var delegate: PassGroupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        filteredData = another_groups
        
        tableView.register(UINib(nibName: "StandartCell", bundle: nil), forCellReuseIdentifier: Constants.standartCell)
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.standartCell, for: indexPath) as?
                StandartCell else {
                    return UITableViewCell()
                }
        cell.usernameLabel.text = filteredData[indexPath.row].name
        cell.userAvatarImageView.image = UIImage(systemName: filteredData[indexPath.row].ava)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        self.delegate!.passGroup(group: filteredData[indexPath.row])
        navigationController?.popToRootViewController(animated: true)
    }

}

// MARK: - extension for searchbar 
extension SearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = another_groups.filter({ $0.name == searchText })
        filteredData = searchText.isEmpty ? another_groups : another_groups.filter({(group) in group.name.contains(searchText) })
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
