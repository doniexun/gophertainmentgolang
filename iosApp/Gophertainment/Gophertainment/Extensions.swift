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

extension UIImageView
{
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }

    func loadImageUsingUrl(urlString: String) {
        let imageLink: String = "https://image.tmdb.org/t/p/w300"
        let imageUrl = URL(string: imageLink + urlString)
        print(imageUrl ?? "No Image Url Path Found")
        if urlString != "No Path" {
            URLSession.shared.dataTask(with: imageUrl!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }).resume()
        } else {
            self.image = UIImage(named: "caution")
        }


    }
}

extension UIView {
    func getSnapshotImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let snapshotImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return snapshotImage
    }
}

