//
//  ResultCellView.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 1/29/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit

class ResultCellView: UICollectionViewCell {

    @IBOutlet weak var resultPosterImage: UIImageView!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultYearLabel: UILabel!

    let imageLink: String = "https://image.tmdb.org/t/p/w300"

    var posterResult: BaseDataModel? {
        didSet {
            resultTitleLabel.text = posterResult?.itemName
            resultYearLabel.text = posterResult?.originDate
            setPosterImage()
            resultPosterImage.image = UIImage(named: (posterResult?.posterPath)!)

        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 5

    }

    func setPosterImage() {
        if let poster = posterResult?.posterPath {
            if (poster != "No Path") {
                let imageUrl = URL(string: imageLink + poster)
                print(imageUrl ?? "No Image Url Path Found")
                URLSession.shared.dataTask(with: imageUrl!, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    DispatchQueue.main.async {
                        self.resultPosterImage.image = UIImage(data: data!)
                    }


                }).resume()
            }
        }
    }


//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }


}
