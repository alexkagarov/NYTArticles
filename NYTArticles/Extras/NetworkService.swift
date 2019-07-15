//
//  NetworkService.swift
//  NYTArticles
//
//  Created by Alex Kagarov on 7/10/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Network Service
struct NetworkService {
    func getData(dataType: String, completion: @escaping Constants.DownloadCompleted) {
        let requestUrl = Constants.baseUrl + dataType + Constants.filename + Constants.apiKey
        AF.request(requestUrl).responseJSON { (response) in
            if let data = response.data {
                switch response.result {
                case .success(_):
                    completion(data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
