//
//  Storyboard.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import Foundation
import UIKit

enum Storyboard: String {
    case main = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}
