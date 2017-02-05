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

    var baseSearchResult: [BaseDataModel]?
    

    var posters = ["One", "Two", "Three", "Four", "Five"]
//    var movieSearchResult: MovieData


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
        return baseSearchResult?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let posterCell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: "resultCellPoster", for: indexPath) as! ResultCellView
        posterCell.resultPosterImage.backgroundColor = UIColor.getRandomColor()
        posterCell.posterResult = baseSearchResult?[indexPath.row]
        return posterCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected poster: \(indexPath.row)")
    }

    func dateFromString(dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let s = dateFormatter.date(from: dateStr)
        if s == nil {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            let ndf = df.date(from: "0001-01-01")
            return ndf!
        }
        return s!
    }



    //MARK: Fetch Search Result
    func fetchSearchResult(userSearchStr: String) {

        let searchURL = URL(string: "https://movieproductiondetails.appspot.com/search/getsearchresult")
        let userSearchString = ["userSearchString" : "\(userSearchStr)"]

        let session = URLSession.shared
        let request = NSMutableURLRequest(url: searchURL!)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: userSearchString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")


        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    if let result = json["results"]! as? [Any] {
                        self.baseSearchResult = [BaseDataModel]()
                        for val in result {
                            if let single = val as? Dictionary<String, Any> {
                                let individualResult = BaseDataModel()
                                individualResult.itemId = single["id"] as! Int?
                                individualResult.itemName = single["title"] as? String ?? single["name"] as? String ?? "No Title/Name"
                                individualResult.originDate = self.dateFromString(dateStr:(single["release_date"] as? String)!)
                                individualResult.overViewOrBio = single["overview"] as? String ?? "No Description"
                                individualResult.posterPath = single["poster_path"] as? String ?? single["profile_path"] as? String ?? "No Path"
                                self.baseSearchResult?.append(individualResult)
                                print("\(individualResult.itemName ?? "No Name Found") : \(individualResult.originDate)")
                            }
                        }
                    }
                    self.baseSearchResult?.sort(by: { $0.originDate?.compare($1.originDate!) == .orderedDescending})
                    DispatchQueue.main.async {
                        self.searchResultCollectionView.reloadData()
                    }

                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }




    //MARK: IBOutlet Actions


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide Keyboard
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text != nil) {
            fetchSearchResult(userSearchStr: textField.text!)
            print(textField.text!)
        }
    }




}

