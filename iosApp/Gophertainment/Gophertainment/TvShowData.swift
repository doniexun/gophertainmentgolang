//
//  TvShowData.swift
//  Gophertainment
//
//  Created by Daksh Sharma on 2/2/17.
//  Copyright © 2017 Daksh Sharma. All rights reserved.
//

import Foundation

class TvShowData {

    /*

     private String productionCompany;
     private String networkName;

     private String[] genre;

     private String[] seasons; // episode count, poster path, season number

     */

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


//    override init(itemId: Int, itemName: String, overView: String, originDate: String, posterPath: String, mediaType: String, backdropPath: String?, popularity: Float?)  {
//        super.init(itemId: itemId, itemName: itemName, overView: overView, originDate: originDate, posterPath: posterPath, mediaType: mediaType, backdropPath: backdropPath, popularity: popularity)
//    }

}
