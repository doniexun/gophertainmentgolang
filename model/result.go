package model

type MultiSearchResult struct {
	Results []struct {
		ID               int     `json:"id"`
		Title            string  `json:"title,omitempty"`
		Name             string  `json:"name,omitempty"`
		Overview         string  `json:"overview"`
		MediaType        string  `json:"media_type"`
		Popularity       float64 `json:"popularity"`
		ReleaseDate      string  `json:"release_date,omitempty"`
		FirstAirDate     string  `json:"first_air_date,omitempty"`
		OriginalLanguage string  `json:"original_language,omitempty"`
		ProfilePath      string  `json:"profile_path,omitempty"`
		PosterPath       string  `json:"poster_path,omitempty"`
		BackdropPath     string  `json:"backdrop_path,omitempty"`
	} `json:"results"`
}
