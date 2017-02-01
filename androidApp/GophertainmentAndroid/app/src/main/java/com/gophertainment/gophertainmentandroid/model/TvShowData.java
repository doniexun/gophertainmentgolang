package com.gophertainment.gophertainmentandroid.model;

/**
 * Created by dakshsharma on 1/31/17.
 */

public class TvShowData extends BaseModel {

    private boolean inProduction;

    private int numOfEpisodes, numOfSeasons;


    private String homePage;
    private String originalLanguage;
    private String productionCompany;
    private String networkName;
    private String status;
    private String firstAirDate;

    private String[] genre;

    private String[] seasons; // episode count, poster path, season number


    private String[] credits; // character, name, profile pic
    private String[] crew;
}
