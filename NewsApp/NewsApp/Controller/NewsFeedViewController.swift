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
        getNewsData()
        
    }
    
    @IBAction func optionsButtonPressed(_ sender: Any) {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                }
    }
    private func activityIndicator(animated: Bool) {
        DispatchQueue.main.async{
            if animated {
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }else{
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        print("info")
    }
    
    
    @IBAction func rightButtonPressed(_ sender: Any) {
    }
    
    
    private func getNewsData(){
        activityIndicator(animated: true)
        
        NetworkManager.fetchData(url: NetworkManager.api) { news in
            self.news = news.articles ?? []
            DispatchQueue.main.async{
                self.tableView.reloadData()
                self.activityIndicator(animated: false)
            }
        }
    }
}
    extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return news.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
                
                let item = news[indexPath.row]
                cell.cellLabel.text = item.title ?? ""
                cell.cellLabel.numberOfLines = 0
                cell.cellImage.sd_setImage(with: URL(string: item.urlToImage ?? ""))
                cell.selectionStyle = .none
                return cell
            }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                
                guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
               
            let item = news[indexPath.row]
            print(item.urlToImage!)
            vc.imageUrl = item.urlToImage!
            vc.titleText = item.title ?? "Title"
            vc.text = item.content
            vc.url = item.url
                navigationController?.pushViewController(vc, animated: true)
            }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        
    }

