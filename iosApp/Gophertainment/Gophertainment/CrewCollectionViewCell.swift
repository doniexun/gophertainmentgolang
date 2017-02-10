//
//  CrewCollectionViewCell.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 2/8/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit


class CrewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var crewTitle: UILabel!
    @IBOutlet weak var crewName: UILabel!
    @IBOutlet weak var crewCellImage: UIImageView!


    var crewNameStr: String? {
        didSet {
            crewName.text = crewNameStr
        }
    }
    var crewTitleStr: String? {
        didSet {
            crewTitle.text = crewTitleStr
        }
    }
    var crewImgPathStr: String? {
        didSet {
            setCrewPosterImage()

        }
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 5
    }


    func setCrewPosterImage() {
        if let poster = crewImgPathStr {
            if (poster != "No Path") {
                let fullImageLink: String = poster
                self.crewCellImage.loadImageUsingUrl(urlString: fullImageLink)
            }
        }
    }
    
}
