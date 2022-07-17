//
//  UIWindow + Extensions.swift
//  42RaceTestAssignment
//
//  Created by Tran Tuyen on 17/07/2022.
//

import UIKit

extension UIWindow {
    var topViewController: UIViewController? {
        var topController = rootViewController
        
        while let newTopController = topController?.presentedViewController {
            topController = newTopController
        }
        return rootViewController
    }
}
