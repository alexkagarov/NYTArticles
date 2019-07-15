//
//  FavouritedViewController.swift
//  NYTArticles
//
//  Created by Alex Kagarov on 7/9/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import UIKit
import CoreData

class FavouritedViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    var articleUrl = ""
    var favouriteArticles = [FavouriteArticle]()
    
    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addFavArticle(notification:)), name: NSNotification.Name(rawValue: "AddFavArticle"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getLocalData()
    }
    
    // MARK: - Functions
    func getLocalData() {
        let fetchRequest: NSFetchRequest<FavouriteArticle> = FavouriteArticle.fetchRequest()
        do {
            let favArticles = try CoreDataStack.context.fetch(fetchRequest)
            self.favouriteArticles = favArticles
            self.tableView.reloadData()
        }
        catch let fetchError {
            print(fetchError)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "favouritedSegue") {
            guard let articleVC = segue.destination as? ArticleViewController else { return }
            articleVC.articleUrl = articleUrl
            articleVC.isFavourite = true
        }
    }
    
    // MARK: - NotificationCenter function
    @objc func addFavArticle(notification: Notification) {
        guard let article = notification.userInfo!["favdArticle"] as? Article else {return}
        
        let favArticle = FavouriteArticle(context: CoreDataStack.context)
        
        favArticle.publishedDate = article.publishedDate
        favArticle.url = article.url
        favArticle.title = article.title
        
        CoreDataStack.saveContext()
        favouriteArticles.append(favArticle)
    }
}

// MARK: - Extensions
extension FavouritedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = favouriteArticles[indexPath.row].url else {
            print("Found empty URL")
            return
        }
        articleUrl = url
        performSegue(withIdentifier: "favouritedSegue", sender: self)
    }
}

extension FavouritedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouritedCell", for: indexPath) as? FavouritedTableViewCell else {
            print("Reusing viewed cell failed")
            return UITableViewCell()
        }
        
        cell.title.text = self.favouriteArticles[indexPath.row].title
        cell.subtitle.text = self.favouriteArticles[indexPath.row].publishedDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataStack.context.delete(favouriteArticles[indexPath.row])
            do {
                try CoreDataStack.context.save()
                favouriteArticles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            catch let error {
                print(error)
            }
        }
    }
}
