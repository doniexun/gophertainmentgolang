//
//  CrewCollectionViewController.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 2/8/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit

class CrewCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    @IBOutlet weak var crewViewCollection: UICollectionView!



    var crewName: [String]?
    var crewTitle: [String]?
    var crewImgPath: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        crewViewCollection.delegate = self
        crewViewCollection.dataSource = self
    }


    //MARK: Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return crewName?.count ?? 0
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let crewCell = crewViewCollection.dequeueReusableCell(withReuseIdentifier: "CrewCellViewPoster",
                                                                for: indexPath) as! CrewCollectionViewCell
        //        posterCell.resultPosterImage.backgroundColor = UIColor.getRandomColor()

        crewCell.crewNameStr = crewName?[indexPath.row]
        crewCell.crewTitleStr = crewTitle?[indexPath.row]
        crewCell.crewImgPathStr = crewImgPath?[indexPath.row]
        return crewCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected poster: \(indexPath.row)")
    }
}
