//
//  Extensions.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 1/30/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit

extension UIColor {
    static func getRandomColor() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }
}

