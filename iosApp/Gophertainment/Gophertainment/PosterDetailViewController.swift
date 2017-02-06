//
//  PosterDetailViewController.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 2/5/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit

class PosterDetailViewController: UIViewController {

    var _details: BaseDataModel!

//    var details: BaseDataModel {
//        get {
//            return _details!
//        }
//        set {
//            _details = BaseDataModel()
//        }
//    }

    @IBOutlet weak var detailBackGroundView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailTaglineLabel: UILabel!
    @IBOutlet weak var detailBudgetLabel: UILabel!
    @IBOutlet weak var detailRevenueLabel: UILabel!
    @IBOutlet weak var detailAverageRatingLabel: UILabel!
    @IBOutlet weak var detailOverviewBioText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(_details.itemName!)
        fetchItemDetailsByID(itemId: _details.itemId!, itemType: _details.mediaType!)
        if self._details?.mediaType == "person" {
            self.detailBackGroundView.loadImageUsingUrl(urlString: (_details?.posterPath)!)
        } else {
            self.detailBackGroundView.loadImageUsingUrl(urlString: (_details?.backDropPath)!)
        }

        self.detailTitleLabel.text = _details?.itemName
        self.detailOverviewBioText.text = _details?.overViewOrBio
        self.detailAverageRatingLabel.text = _details?.voteAvg?.description
    }

    func personDetailSuppress() {
        if self._details?.mediaType == "person" {
            
        }
    }

    @IBAction func closePosterDetail(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2;
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: value as NSNumber);
        return result!;
    }


    //MARK: Fetch Specific Item Details
    func fetchItemDetailsByID(itemId: Int, itemType: String) {
        var idUrl: String = "https://movieproductiondetails.appspot.com/"
        var detailItemId: [String: String]
        if itemType == "person" {
            idUrl = "https://movieproductiondetails.appspot.com/person/getpersondetails"
            detailItemId = ["personId": "\(itemId)"]
        } else if itemType == "tv" {
            idUrl = "https://movieproductiondetails.appspot.com/tvshow/gettvshowdetails"
            detailItemId = ["tvshowId": "\(itemId)"]
        } else {
            idUrl = "https://movieproductiondetails.appspot.com/movie/getmoviedetails"
            detailItemId = ["movieId": "\(itemId)"]
        }

        let detailURL = URL(string: idUrl)
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: detailURL!)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: detailItemId, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    self._details.budget = json["budget"] as? Double ?? 0.0
                    self._details.revenue = json["revenue"] as? Double ?? 0.0
                    self._details.tagLine = json["tagline"] as? String ?? " "
                    if self._details?.mediaType == "person" {
                        self._details.overViewOrBio = json["biography"] as? String ?? "No Biography Found"
                    }

                    DispatchQueue.main.async {
                        self.detailTaglineLabel.text = self._details?.tagLine
                        if let budget = self._details?.budget {
                            self.detailBudgetLabel.text = "Budget: \(self.formatCurrency(value: budget))"
                        }
                        if let revenue = self._details?.revenue {
                            self.detailRevenueLabel.text = "Revenue: \(self.formatCurrency(value: revenue))"
                        }
                        if self._details?.mediaType == "person" {
                            self.detailOverviewBioText.text = self._details?.overViewOrBio
                        }
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }

        })
        task.resume()

    }
}
