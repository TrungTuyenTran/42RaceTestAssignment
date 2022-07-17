//
//  CategoryModel.swift
//  Repository
//
//  Created by Tran Tuyen on 17/07/2022.
//

import Foundation

public struct ListCategoryModel: Codable {
    public var categories: [CategoryModel]
}

public struct CategoryModel: Codable {
    public var alias: String
    public var title: String
}
