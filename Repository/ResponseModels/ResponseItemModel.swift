//
//  ResponseItemModel.swift
//  Repository
//
//  Created by Tran Tuyen on 27/06/2022.
//

import Foundation

public struct ResponseItemModel: Codable {
    public var id: String
    public var alias: String
    public var name: String
    public var image_url: String
    public var is_closed: Bool
    public var categories: [CategoryModel]
    public var rating: Double
    public var location: LocationModel
    public var display_phone: String
}

public struct LocationModel: Codable {
    public var address1: String
    public var address2: String?
    public var address3: String?
    public var city: String
    public var zip_code: String
    public var country: String
    public var state: String
    public var display_address: [String]

    public var addressString: String {
        var result = ""
        for address in display_address {
            result += address + " "
        }
        return result
    }
}

