//
//  ResultCellView.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 1/29/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit

class ResultCellView: UICollectionViewCell {

    @IBOutlet weak var posterInfoBgView: UIView!
    @IBOutlet weak var resultPosterImage: UIImageView!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultYearLabel: UILabel!

    var image: UIImage!
    var blurView = UIImageView()

    let imageLink: String = "https://image.tmdb.org/t/p/w300"

    var posterResult: BaseDataModel? {
        didSet {
            resultTitleLabel.text = posterResult?.itemName
            resultYearLabel.text = yearDateOfPoster(yearString: (posterResult?.originDate!.description)!)
            setPosterImage()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 5


    }

//    func snapShotImage() -> UIImage {
//        UIGraphicsBeginImageContext(self.posterInfoBgView.bounds.size)
//        if let context = UIGraphicsGetCurrentContext() {
//            self.layer.render(in: context)
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return image!
//        }
//        return UIImage()
//    }

//    func blurImage(image: UIImage) {
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.posterInfoBgView.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.posterInfoBgView.insertSubview(blurEffectView, at: 0)
//    }



    // See http://stackoverflow.com/a/39677331 for substring
    func yearDateOfPoster(yearString: String) -> String {
        let index = yearString.index(yearString.startIndex, offsetBy: 4)
        return (yearString.substring(to: index) != "0001") ? yearString.substring(to: index) : ""
    }

    func setPosterImage() {
        if let poster = posterResult?.posterPath {
            if (poster != "No Path") {
                let fullImageLink: String = poster
                self.resultPosterImage.loadImageUsingUrl(urlString: fullImageLink)
//                let image = self.snapShotImage()
//                self.blurImage(image: image)
            }
        }
    }
}
