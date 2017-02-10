//
//  ActorCollectionView.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 2/7/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit

class ActorCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    @IBOutlet weak var actorViewCollection: UICollectionView!

    var actorName: [String]? {
        didSet {
//            print(actorName!)
        }
    }
    var characterName: [String]?
    var actorImgPath: [String]?


    override func viewDidLoad() {
        super.viewDidLoad()
        actorViewCollection.delegate = self
        actorViewCollection.dataSource = self
    }


    //MARK: Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actorName?.count ?? 0
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let actorCell = actorViewCollection.dequeueReusableCell(withReuseIdentifier: "actorCellViewPoster",
                                                                        for: indexPath) as! ActorCollectionViewCell
        //        posterCell.resultPosterImage.backgroundColor = UIColor.getRandomColor()
        actorCell.actorName = actorName?[indexPath.row]
        actorCell.characterName = characterName?[indexPath.row]
        actorCell.actorImgPath = actorImgPath?[indexPath.row]
        return actorCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected poster: \(indexPath.row)")
    }


}
