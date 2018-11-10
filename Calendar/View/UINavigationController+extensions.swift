//
//  UINavigationController+extensions.swift
//  Calendar
//
//  Created by Lubos Ilcik on 10/11/2018.
//  Copyright © 2018 Touch4It s.r.o. All rights reserved.
//

import UIKit

extension UINavigationController {
    var hideShadow: Bool {
        get {
            return navigationBar.value(forKey: "hidesShadow") as! Bool
        }
        set {
            navigationBar.setValue(newValue, forKey: "hidesShadow")
        }
    }
}
