//
//  WebViewController.swift
//  NewsApp
//
//  Created by d.chernov on 14/05/2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var urlString: String?
    
    @IBOutlet weak var web: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let url = URL(string: urlString!) else {return}
        
        web.load(URLRequest(url: url))
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
