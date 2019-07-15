//
//  ArticleModel.swift
//  NYTArticles
//
//  Created by Alex Kagarov on 7/10/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import Foundation

// MARK: - Response model (simplified)
class JSONResponse: Decodable {
    var results: [Article]
}

// MARK: - Article model (simplified)
class Article: Decodable {
    var url: String?
    var title: String?
    var publishedDate: String?
}
