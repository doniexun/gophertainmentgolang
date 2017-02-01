//
//  ViewController.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 1/29/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {


    //MARK: IBOutlet Views
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultCollectionView: UICollectionView!

    var posters = ["One", "Two", "Three", "Four", "Five"]


    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: Delagates
        searchTextField.delegate = self
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self

        // Search Text Field Customization
        searchTextField.placeholder = "Search movies, actors, directors..."
        searchTextField.borderStyle = UITextBorderStyle(rawValue: 0)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let posterCell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: "resultCellPoster", for: indexPath) as! ResultCellView
        posterCell.resultPosterImage.backgroundColor = UIColor.getRandomColor()
        posterCell.resultTitleLabel.text = posters[indexPath.row]
        return posterCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected poster: \(indexPath.row)")
    }


    


    //MARK: IBOutlet Actions


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide Keyboard
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text != nil) {
            print(textField.text!)
        }
    }




}

