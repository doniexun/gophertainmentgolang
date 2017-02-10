//
//  ActorCollectionViewCell.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 2/7/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var actorCellImage: UIImageView!
    @IBOutlet weak var actorCellName: UILabel!
    @IBOutlet weak var actorCellCharacterName: UILabel!

    var position: Int?
    var actorName: String? {
        didSet {
            actorCellName.text = actorName
        }
    }
    var characterName: String? {
        didSet {
            actorCellCharacterName.text = characterName
        }
    }
    var actorImgPath: String? {
        didSet {
            setActorPosterImage()
        }

    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 5
    }


    func setActorPosterImage() {
        if let poster = actorImgPath {
            if (poster != "No Path") {
                let fullImageLink: String = poster
                self.actorCellImage.loadImageUsingUrl(urlString: fullImageLink)
            }
        }
    }
}
