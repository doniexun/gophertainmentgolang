//
//  PosterDetailViewController.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 2/5/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit

class PosterDetailViewController: UIViewController {

    @IBOutlet weak var detailBackGroundView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailTaglineLabel: UILabel!
    @IBOutlet weak var detailBudgetLabel: UILabel!
    @IBOutlet weak var detailRevenueLabel: UILabel!
    @IBOutlet weak var detailAverageRatingLabel: UILabel!
    @IBOutlet weak var detailOverviewBioText: UITextView!
    @IBOutlet weak var detailRunTimeLabel: UILabel!



    var _details: BaseDataModel? {
        didSet {
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        setOverViewData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setOverViewData() {
        if let detailType = self._details?.mediaType {
            if detailType == "person" {
                self.detailBackGroundView.loadImageUsingUrl(urlString: (_details?.posterPath)!)
            } else {
                self.detailBackGroundView.loadImageUsingUrl(urlString: (_details?.backDropPath)!)
            }
        }
        if let itmName = self._details?.itemName {
            self.detailTitleLabel.text = itmName
        }
        if let overView = self._details?.overViewOrBio {
            self.detailOverviewBioText.text = overView
        }
        if let rating = _details?.voteAvg {
            self.detailAverageRatingLabel.text = "\(rating) \u{2606}" // star character
        }
        if let tagline = self._details?.tagLine {
            self.detailTaglineLabel.text = tagline
        }
        if let budget = self._details?.budget {
            self.detailBudgetLabel.text = "Budget: \(self.formatCurrency(value: budget))"
        }
        if let revenue = self._details?.revenue {
            self.detailRevenueLabel.text = "Revenue: \(self.formatCurrency(value: revenue))"
        }
        if self._details?.mediaType == "person" {
            self.detailOverviewBioText.text = self._details?.overViewOrBio
        }
        if let runtime = self._details?.runtime {
            self.detailRunTimeLabel.text = "\(runtime) min"
        }
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
                    self._details?.budget = json["budget"] as? Double ?? 0.0
                    self._details?.revenue = json["revenue"] as? Double ?? 0.0
                    self._details?.tagLine = json["tagline"] as? String ?? " "
                    self._details?.runtime = json["runtime"] as? Int ?? 0
                    if self._details?.mediaType == "person" {
                        self._details?.overViewOrBio = json["biography"] as? String ?? "No Biography Found"
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
                        if let runtime = self._details?.runtime {
                            self.detailRunTimeLabel.text = "\(runtime) min"
                        }
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }

        })
        task.resume()
        
    }

//
//    func fetchDetailOverViewById(id: Int, itemType: String) {
//        let idAndType = filterDetailByItemType(id: id, type: itemType)
//        let detailURL = URL(string: idAndType.url)
//        let session = URLSession.shared
//        let request = NSMutableURLRequest(url: detailURL!)
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: idAndType.itemID, options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        taskForUrlSession(req: request as URLRequest, session: session)
//    }
//
//    func filterDetailByItemType(id: Int, type: String) -> (url: String, itemID: [String: String]) {
//        var idUrl: String = "https://movieproductiondetails.appspot.com/"
//        var detailItemId: [String: String]
//        if type == "person" {
//            idUrl = "https://movieproductiondetails.appspot.com/person/getpersondetails"
//            detailItemId = ["personId": "\(id)"]
//        } else if type == "tv" {
//            idUrl = "https://movieproductiondetails.appspot.com/tvshow/gettvshowdetails"
//            detailItemId = ["tvshowId": "\(id)"]
//        } else {
//            idUrl = "https://movieproductiondetails.appspot.com/movie/getmoviedetails"
//            detailItemId = ["movieId": "\(id)"]
//        }
//        return (idUrl, detailItemId)
//    }
//
//    func taskForUrlSession(req: URLRequest, session: URLSession) {
//        let task = session.dataTask(with: req as URLRequest, completionHandler: { data, response, error in
//            guard error == nil else { return }
//            guard let data = data else { return }
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
//                    self._details?.budget = json["budget"] as? Double ?? 0.0
//                    self._details?.revenue = json["revenue"] as? Double ?? 0.0
//                    self._details?.tagLine = json["tagline"] as? String ?? "..."
//                    self._details?.runtime = json["runtime"] as? Int ?? 0
//                    if self._details?.mediaType == "person" {
//                        self._details?.overViewOrBio = json["biography"] as? String ?? "No Biography Found"
//                    }
//                    DispatchQueue.main.async {
//                        print(self._details?.tagLine)
//                        self.detailTaglineLabel.text = self._details?.tagLine
//                        self.detailRunTimeLabel.text = "\(self._details?.runtime)"
//                        self.detailBudgetLabel.text = "Budget: \(self._details?.budget)"
//                        self.detailRevenueLabel.text = "Revenue: \(self._details?.revenue)"
//                    }
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        })
//        task.resume()
//    }
}
