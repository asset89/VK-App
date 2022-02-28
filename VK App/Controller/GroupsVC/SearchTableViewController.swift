//
//  SearchTableViewController.swift
//  VK App
//
//  Created by Asset Ryskul on 17.12.2021.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredData = [Group]()
    
    private let networkService = NetworkService()
    
    var delegate: PassGroupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
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
        cell.userAvatarImageView.sd_setImage(with: URL(string: filteredData[indexPath.row].photo200), placeholderImage: UIImage(named: "film.fill"))
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
        networkService.fetchSearchGroups(searchText) { [weak self] result in
            switch result {
            case .success(let group):
                self?.filteredData = group.response.items
            case .failure(let error):
                print(error)
            }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
