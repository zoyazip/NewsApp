//
//  DetailViewController.swift
//  NewsApp
//
//  Created by d.chernov on 14/05/2023.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var url: String?
    var imageUrl: String?
    var titleText: String = "Title"
    var text: String?
    
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var detailParagraph: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailParagraph.text = text
        detailLabel.text = titleText
        detailImage.sd_setImage(with: URL(string: imageUrl ?? "https://nbhc.ca/sites/default/files/styles/article/public/default_images/news-default-image%402x_0.png?itok=B4jML1jF"))
        
    }
    
    
    @IBAction func detailSavedButtonPressed(_ sender: Any) {
        saveDataToCoreData()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webSegue",
           let destinationVC = segue.destination as? WebViewController {
            destinationVC.urlString = url!
        }
        
    }
    
    func saveDataToCoreData(){
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let entityName = "SavedNews"
            
            // Check if the string already exists in Core Data
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fetchRequest.predicate = NSPredicate(format: "title = %@", titleText)
            fetchRequest.predicate = NSPredicate(format: "newsPicture = %@", imageUrl ?? "https://nbhc.ca/sites/default/files/styles/article/public/default_images/news-default-image%402x_0.png?itok=B4jML1jF")
            fetchRequest.predicate = NSPredicate(format: "url = %@", url ?? "")
            fetchRequest.predicate = NSPredicate(format: "content = %@", text ?? "")
            
            do {
                let fetchResults = try managedContext.fetch(fetchRequest)
                if fetchResults.isEmpty {
                    // The string doesn't exist, create a new object and save it
                    guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
                        return
                    }
                    
                    let object = NSManagedObject(entity: entity, insertInto: managedContext)
                    object.setValue(titleText, forKey: "title")
                    object.setValue(imageUrl, forKey: "newsPicture")
                    object.setValue(url, forKey: "url")
                    object.setValue(text, forKey: "content")
                    
                    do {
                        try managedContext.save()
                        
                        print("String data saved to Core Data successfully.")
                    } catch {
                        print("Error saving string data to Core Data: \(error.localizedDescription)")
                    }
                } else {
                    print("String data already exists in Core Data.")
                }
            } catch {
                print("Error fetching data from Core Data: \(error.localizedDescription)")
            }
        }
}
