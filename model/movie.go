package model

type Movie struct {
	ID                  int     `json:"id"`
	Title               string  `json:"title,omitempty"`
	Overview            string  `json:"overview,omitempty"`
	Tagline             string  `json:"tagline,omitempty"`
	Runtime             int     `json:"runtime,omitempty"`
	Budget              int     `json:"budget,omitempty"`
	Revenue             int     `json:"revenue,omitempty"`
	Popularity          float64 `json:"popularity,omitempty"`
	Release_Date        string  `json:"release_date,omitempty"`
	Original_Title      string  `json:"original_title,omitempty"`
	Status              string  `json:"status,omitempty"`
	BackdropPath        string  `json:"backdrop_path,omitempty"`
	PosterPath          string  `json:"poster_path,omitempty"`
	Homepage            string  `json:"homepage,omitempty"`
	BelongsToCollection `json:"belongs_to_collection,omitempty"`
	Credits             `json:"credits,omitempty"`
}

type BelongsToCollection struct {
	ID           int    `json:"id"`
	Name         string `json:"name,omitempty"`
	PosterPath   string `json:"poster_path,omitempty"`
	BackdropPath string `json:"backdrop_path,omitempty"`
}