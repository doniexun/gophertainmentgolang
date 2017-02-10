//
//  DetailPageViewController.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 2/7/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import UIKit

class DetailPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var detailBaseData: BaseDataModel? {
        didSet {

        }
    }

    func updateCurrentViewController() {
        if let firstVC = vcArray.last {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

    lazy var vcArray: [UIViewController] = {
        return [
            self.viewInstance(name: "PosterOverViewDetail"),
            self.viewInstance(name: "ActorOverViewDetail"),
            self.viewInstance(name: "CrewOverViewDetail")
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        fetchItemDetailsByID(itemId: (detailBaseData?.itemId)!, itemType: (detailBaseData?.mediaType)!)
    }

    private func viewInstance(name: String) -> UIViewController {
        if name == "PosterOverViewDetail" {
            let posterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name) as! PosterDetailViewController
            posterVC._details = detailBaseData
            return posterVC
        } else if name == "ActorOverViewDetail" {
            let posterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name) as! ActorCollectionViewController
            posterVC.actorName = detailBaseData?.castName
            posterVC.characterName = detailBaseData?.castCharacterName
            posterVC.actorImgPath = detailBaseData?.castImageLink
            return posterVC
        } else if name == "CrewOverViewDetail" {
            let posterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name) as! CrewCollectionViewController
            posterVC.crewName = detailBaseData?.castName
            posterVC.crewTitle = detailBaseData?.castCharacterName
            posterVC.crewImgPath = detailBaseData?.castImageLink
            return posterVC
        }
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }



    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard  let vcIndex = vcArray.index(of: viewController) else {
            return nil
        }
        let previoudVCIndex = vcIndex - 1

        guard previoudVCIndex >= 0 else {
            return vcArray.last
        }
        guard vcArray.count > previoudVCIndex else {
            return nil
        }
        return vcArray[previoudVCIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard  let vcIndex = vcArray.index(of: viewController) else {
            return nil
        }
        let nextVCIndex = vcIndex + 1

        guard nextVCIndex != vcArray.count else {
            return vcArray.first
        }
        guard vcArray.count > nextVCIndex else {
            return nil
        }

        return vcArray[nextVCIndex]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcArray.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = viewControllers?.first, let firstVCIndex = vcArray.index(of: firstVC) else {
            return 0
        }
        return firstVCIndex
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
                    self.detailBaseData?.budget = json["budget"] as? Double ?? 0.0
                    self.detailBaseData?.revenue = json["revenue"] as? Double ?? 0.0
                    self.detailBaseData?.tagLine = json["tagline"] as? String ?? " "
                    self.detailBaseData?.runtime = json["runtime"] as? Int ?? 0
                    if let credits = json["credits"]! as? Dictionary<String, Any> {
                        if let creditType = credits as? Dictionary<String, Any> {
                            for castCrew in creditType {
                                if castCrew.key == "cast" {
                                    for item in (castCrew.value as? [[String:Any]])! {
                                        for characterCast in (item as? [String:Any])! {
                                            if characterCast.key == "name" {
                                                self.detailBaseData?.castName?.append(characterCast.value as! String)
                                            }
                                            if characterCast.key == "character" {
                                                self.detailBaseData?.castCharacterName?.append(characterCast.value as! String)
                                            }
                                            if characterCast.key == "profile_path" {
                                                self.detailBaseData?.castImageLink?.append(characterCast.value as! String)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if self.detailBaseData?.mediaType == "person" {
                        self.detailBaseData?.overViewOrBio = json["biography"] as? String ?? "No Biography Found"
                    }

                    DispatchQueue.main.async {
                        self.updateCurrentViewController()
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }

        })
        task.resume()
    }



//    //MARK: Network Calls
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
//                    self.detailBaseData.budget = json["budget"] as? Double ?? 0.0
//                    self.detailBaseData.revenue = json["revenue"] as? Double ?? 0.0
//                    self.detailBaseData.tagLine = json["tagline"] as? String ?? "..."
//                    self.detailBaseData.runtime = json["runtime"] as? Int ?? 0
//                    if self.detailBaseData?.mediaType == "person" {
//                        self.detailBaseData.overViewOrBio = json["biography"] as? String ?? "No Biography Found"
//                    }
//                    DispatchQueue.main.async {
//                        let posterVC = self.viewInstance(name: "PosterOverViewDetail") as! PosterDetailViewController
//                        posterVC._details = self.detailBaseData
//                        print(String(describing: self.detailBaseData?.tagLine))
//                        self.reloadInputViews()
//                        self.updateCurrentViewController()
//
//                    }
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        })
//        task.resume()
//    }
}
