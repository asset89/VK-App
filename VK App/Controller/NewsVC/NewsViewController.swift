//
//  NewsViewController.swift
//  VK App
//
//  Created by Asset Ryskul on 04.04.2022.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let networkService = NetworkService()
    
    private var news = [NewsStruct](){
        didSet {
            print("start")
            self.getGroup()
        }
    }
    private var groups = [Group](){
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        networkService.fetchNews() { [weak self] result in
            switch result {
            case .success(let news):
                DispatchQueue.main.async {
                    self?.news = news.response.items
                }
                //self?.news = news.response.items
                print("finish")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getGroup() {
        DispatchQueue.main.async {
            for item in self.news {
                sleep(1)
                self.networkService.fetchGroupById(id: item.sourceId) { [weak self] result in
                    switch result {
                    case .success(let groupResponse):
                        self?.groups.append(groupResponse.response.first!)
                        print("finish 2")
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "headerCell")
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.standartCell) as StandartCell else {return UITableViewCell()
            }
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") else {return UITableViewCell()
            }
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell") else {return UITableViewCell()
            }
            return cell
        } else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell") else {return UITableViewCell()
            }
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 68.0
        }
        return UITableView.automaticDimension
    }
    
    
}
