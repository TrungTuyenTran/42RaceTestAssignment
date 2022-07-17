//
//  Constants.swift
//  Repository
//
//  Created by Tran Tuyen on 27/06/2022.
//

import Foundation

struct Constants {
    static let baseUrl = "https://api.yelp.com/v3/"
}

enum API {
    case search
    case categories
    
    var url: String {
        switch self {
        case .search:
            return Constants.baseUrl + "businesses/search"
        case .categories:
            return Constants.baseUrl + "categories"
        }
    }
}
