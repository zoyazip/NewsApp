//
//  ViewController.swift
//  NewsApp
//
//  Created by d.chernov on 14/05/2023.
//

import UIKit
import SDWebImage

class NewsFeedViewController: UIViewController {
    private var news: [Article] = []
    

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple News"
    }
    

    @IBAction func infoButtonPressed(_ sender: Any) {
        print("info")
    }
    
    
    @IBAction func rightButtonPressed(_ sender: Any) {
    }
    private func activityIndicator(animated: Bool){
        DispatchQueue.main.async{
            if animated {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }
            else{
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func getNewsData(){
        activityIndicator(animated: true)
        NetworkManager.fetchData { newsItems in
            self.news = newsItems.articles ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator(animated: false)
            }
        }
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        
        let item = news[indexPath.row]
        cell.cellLabel.text = item.title
        cell.cellLabel.numberOfLines = 0
        cell.cellImage.sd_setImage(with: URL(string: item.urlToImage))
        
        return cell
    }
    
}
