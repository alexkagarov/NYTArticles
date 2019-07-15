//
//  SharedViewController.swift
//  NYTArticles
//
//  Created by Alex Kagarov on 7/9/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import UIKit

class SharedViewController: UIViewController {
    
    // MARK: - Variables
    var articleUrl = ""
    var netSvc = NetworkService()
    var articles = [Article]()
    var selectedArticle: Article?
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        getData()
    }
    
    // MARK: - Functions
    func getData() {
        self.articles = []
        self.tableView.reloadData()
        netSvc.getData(dataType: Constants.infoType.shared.rawValue) { data in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseResult = try decoder.decode(JSONResponse.self, from: data)
                for article in responseResult.results {
                    self.articles.append(article)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "sharedSegue") {
            guard let articleVC = segue.destination as? ArticleViewController else { return }
            articleVC.articleUrl = articleUrl
            articleVC.article = selectedArticle
        }
    }
}

// MARK: - Extensions
extension SharedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = articles[indexPath.row].url else {
            print("Found empty URL")
            return
        }
        articleUrl = url
        selectedArticle = articles[indexPath.row]
        performSegue(withIdentifier: "sharedSegue", sender: self)
    }
}

extension SharedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sharedCell", for: indexPath) as? SharedTableViewCell else {
            print("Reusing shared cell failed")
            return UITableViewCell()
        }
        
        cell.title.text = self.articles[indexPath.row].title
        cell.subtitle.text = self.articles[indexPath.row].publishedDate
        
        return cell
    }
}
