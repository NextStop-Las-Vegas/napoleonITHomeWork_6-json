//
//  NewsTableViewController.swift
//  new applet
//
//  Created by Pavel on 30.08.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

struct NewsPage: Decodable{
    var status: String
    var totalResults: Int
    var articles: [Articles]
}

struct Articles: Decodable{
    var source: Source
    var author: String
    var title: String
    var description: String
    var url: URL
    var urlToImage: URL
    var publishedAt: String
    var content: String
}

struct Source: Decodable{
    var id: String?
    var name: String
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {
                (response, data, error) in
                if let imageData = data as Data? {
                    self.image = UIImage(data: imageData as Data)
                }
            }
        }
    }
}


class NewsTableViewController: UITableViewController {
    
    var globalModel: [Articles]?
    
    
    var newsArray = [
        NewsModel(header: "zagolovok", news: "kakietonovosti", picture: "pik4a"),
        NewsModel(header: "zagolovok2", news: "kakietonovosti", picture: "pik4a"),
        NewsModel(header: "zagolovok3", news: "kakietonovosti", picture: "pik4a"),
        NewsModel(header: "zagolovok4", news: "kakietonovosti", picture: "pik4a")
        
    ]
    
    func urlControlMissingHuisingBlyat (callBack: @escaping ([Articles]) -> ()) {
        
        
                let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=3447bef969844bfbbf35b3133006cc11"
//        let urlString = "http://newsapi.org/v2/everything?q=bitcoin&from=2020-11-21&sortBy=publishedAt&apiKey=3447bef969844bfbbf35b3133006cc11"
//
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let newsPage = try JSONDecoder().decode(NewsPage.self, from: data)
                let name = newsPage.articles
                callBack(name)
                print(name)
            }
            catch let error {
                print(error) }
        }
        .resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlControlMissingHuisingBlyat { (name) in
            self.globalModel = name
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let globalModel = self.globalModel else {return 1}
        return globalModel.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerID", for: indexPath) as! NewsTableViewCell
        guard let globalModel = self.globalModel else { return UITableViewCell() }
        let newsModel = globalModel[indexPath.row]
        cell.set(newsModel: newsModel)
        
        return cell
    }
}
