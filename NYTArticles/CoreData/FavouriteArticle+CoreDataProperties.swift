//
//  FavouriteArticle+CoreDataProperties.swift
//  NYTArticles
//
//  Created by Alex Kagarov on 7/15/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//
//

import Foundation
import CoreData


extension FavouriteArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteArticle> {
        return NSFetchRequest<FavouriteArticle>(entityName: "FavouriteArticle")
    }

    @NSManaged public var publishedDate: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
