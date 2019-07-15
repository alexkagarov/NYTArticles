//
//  Constants.swift
//  NYTArticles
//
//  Created by Alex Kagarov on 7/10/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import Foundation

// MARK: - Constants
struct Constants {
    typealias DownloadCompleted = (Data) -> ()
    
    static let baseUrl = "https://api.nytimes.com/svc/mostpopular/v2"
    
    enum infoType: String {
        case emailed = "/emailed"
        case shared = "/shared"
        case viewed = "/viewed"
    }
    
    static let filename = "/30.json?"
    
    static let apiKey = "api-key=QxRhVmkFsOOged1RPBCAFWQ8tHTnazwF"
}
