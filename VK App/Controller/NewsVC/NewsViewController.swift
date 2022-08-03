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
    private let queue = DispatchQueue(label: "LocalQueue", qos: .default, attributes: .concurrent)
    
    private var news = [NewsStruct](){
        didSet {
            DispatchQueue.main.async {
                self.getGroup()
            }
            
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
        
        tableView.register(UINib(nibName: "StandartCell", bundle: nil), forCellReuseIdentifier: Constants.standartCell)
            self.networkService.fetchNews() { [weak self] result in
                switch result {
                case .success(let news):
                    self?.news = news.response.items
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
    private func getGroup() {
        for item in self.news {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.networkService.fetchGroupById(id: item.sourceId) { [weak self] result in
                    switch result {
                    case .success(let groupResponse):
                        self?.groups.append(groupResponse.response.first!)
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.standartCell) as? StandartCell else {return UITableViewCell()
            }
            let titleLabel = cell.usernameLabel
            titleLabel?.text = groups[indexPath.section].name
            let avaImageView = cell.userAvatarImageView!
            avaImageView.sd_setImage(with: URL(string: groups[indexPath.section].photo200), placeholderImage: UIImage(named: "user1"))
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell") else {return UITableViewCell()
            }
            cell.textLabel?.text = news[indexPath.section].text
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell") else {return UITableViewCell()
            }
            let img = cell.viewWithTag(1) as! UIImageView
            let imageAttachment = news[indexPath.section].attachments?.first
            let imageUrl = imageAttachment?.photo?.sizes[4].url
            img.sd_setImage(with: URL(string: imageUrl ?? ""), placeholderImage: UIImage(named: "user1"))
            return cell
        } else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell") else {return UITableViewCell()
            }
            let likeLabel = cell.viewWithTag(1) as! UILabel
            let commentLabel = cell.viewWithTag(3) as! UILabel
            likeLabel.text = "\(news[indexPath.section].likes.count)"
            commentLabel.text = "\(news[indexPath.section].comments.count)"
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 78.0
        } else if indexPath.row == 1 {
            if news[indexPath.section].text == "" {
                return 0
            }
        } else if indexPath.row == 2 {
            return 400.0
        }
        return UITableView.automaticDimension
    }
    
    
}
