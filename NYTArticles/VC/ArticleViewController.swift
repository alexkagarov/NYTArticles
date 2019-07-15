//
//  ArticleViewController.swift
//  NYTArticles
//
//  Created by Alex Kagarov on 7/9/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Variables
    var webView: WKWebView!
    var articleUrl = "https://google.com"
    var article: Article?
    var isFavourite: Bool?
    
    // MARK: - Outlets
    @IBOutlet weak var addToFavsBtn: UIButton!
    
    // MARK: - Actions
    @IBAction func addToFavsTapped(_ sender: UIButton) {
        if addToFavsBtn.isEnabled {
            let alert = UIAlertController(title: "Success!", message: "Article added to favourites!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            addFavArticle(article!)
            addToFavsBtn.isEnabled.toggle()
        }
    }
    
    // MARK: - ViewController life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let isFav = self.isFavourite {
            addToFavsBtn.isEnabled = !isFav
        }
        
        let url = URL(string: articleUrl)!
        webView.load(URLRequest(url: url))
    }
    
    // MARK: - Functions
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    func addFavArticle(_ article: Article) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AddFavArticle"), object: nil, userInfo:["favdArticle": article])

        print("\(article.title!) added to favs")
    }
}
