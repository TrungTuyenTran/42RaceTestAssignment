//
//  UITableViewCell + Extensions.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//
import UIKit

extension UITableViewCell {
    static var cellId: String {
        return String(describing: self)
    }
}
