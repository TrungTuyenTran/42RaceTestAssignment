//
//  UserDefaultInfo.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import Repository
import Foundation

struct UserDefaultInfo {
    static var categories: [CategoryModel]? {
        get {
            if let data = UserDefaults.standard.value(forKey:"categories") as? Data {
                let categories = try? PropertyListDecoder().decode(Array<CategoryModel>.self, from: data)
                return categories
            }
            return nil
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey:"categories")
        }
    }
}

extension Dictionary where Key == String {
    public func decoded<T: Codable>() -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else { return nil }
        var result: T?
        do {
            result = try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Parse dictionary to object error: \(error.localizedDescription)")
        }
        return result
    }
}

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}

// MARK: - Encode from objective to dictionary
extension Encodable {
    public func asDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return nil
            }
            return dictionary
        } catch {
            return nil
        }
    }
}

