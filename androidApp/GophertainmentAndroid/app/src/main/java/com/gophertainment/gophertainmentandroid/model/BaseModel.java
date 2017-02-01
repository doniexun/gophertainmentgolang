package com.gophertainment.gophertainmentandroid.model;

/**
 * Created by dakshsharma on 1/31/17.
 */

public class BaseModel {
    private int itemId;

    private double popularity;

    private String nameTitle;
    private String posterPath;
    private String backDropPath;
    private String overViewOrBio;

    // person birthday, movie release date, tvshow first episode air date
    private String originDate;

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public double getPopularity() {
        return popularity;
    }

    public void setPopularity(double popularity) {
        this.popularity = popularity;
    }

    public String getNameTitle() {
        return nameTitle;
    }

    public void setNameTitle(String nameTitle) {
        this.nameTitle = nameTitle;
    }

    public String getPosterPath() {
        return posterPath;
    }

    public void setPosterPath(String posterPath) {
        this.posterPath = posterPath;
    }

    public String getBackDropPath() {
        return backDropPath;
    }

    public void setBackDropPath(String backDropPath) {
        this.backDropPath = backDropPath;
    }

    public String getOverViewOrBio() {
        return overViewOrBio;
    }

    public void setOverViewOrBio(String overViewOrBio) {
        this.overViewOrBio = overViewOrBio;
    }

    public String getOriginDate() {
        return originDate;
    }

    public void setOriginDate(String originDate) {
        this.originDate = originDate;
    }
}
