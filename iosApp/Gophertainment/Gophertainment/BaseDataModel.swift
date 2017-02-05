//
//  BaseDataModel.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 2/2/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import Foundation


class BaseDataModel: NSObject {

    /* 
        originDate: person birthday, movie release date, tvshow first episode air date
     */

    var itemId: Int?

    var itemName: String?
    var overViewOrBio: String?
    var originDate: Date?
    var mediaType: String?
    
    var posterPath: String?
    var backDropPath: String?
    var popularity: Float?

    //MARK: Movie Details     
    var budget: Double?
    var revenue: Double?
    var voteAvg: Double?

    var voteCount: Int?
    var runtime: Int?

    var tagLine: String?
    var status: String?
    var releaseDate: String?


    //MARK: Person Details
    var birthday: String?

    var deathday: String?
    var placeOfBirth: String?

    var imageProfiles: [String]?

    //MARK: Tv Show Details
    var inProduction: Bool?

    var numberOfSeasons: Int?
    var tvSeasons: [String:String]?
    var numberOfEpisodes: Int?

    var originalLanguage: String?
    var productionCompany: String?
    var networkName: String?
    var currentStatus: String?

    var firstAirDate: String?

    var homePageLink: String? // website link to the official site
    var cast: [String: String]? // character, name, profile pic
    var crew: [String: String]?
    var genres: [String]?


//    init(itemId: Int, itemName: String, overView: String, originDate: String, posterPath: String, mediaType: String, backdropPath: String?, popularity: Float?) {
//        self.itemId = itemId
//        self.itemName = itemName
//        self.overViewOrBio = overView
//        self.originDate = originDate
//        self.posterPath = posterPath
//        self.mediaType = mediaType
//        self.backDropPath = backdropPath
//        self.popularity = popularity
//    }
}
