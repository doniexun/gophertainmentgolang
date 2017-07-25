package model

type TvShow struct {
	ID               int    `json:"id"`
	Name             string `json:"name,omitempty"`
	Overview         string `json:"overview,omitempty"`
	PosterPath       string `json:"poster_path,omitempty"`
	BackdropPath     string `json:"backdrop_path,omitempty"`
	Homepage         string `json:"homepage,omitempty"`
	FirstAirDate     string `json:"first_air_date,omitempty"`
	LastAirDate      string `json:"last_air_date,omitempty"`
	NumberOfEpisodes int    `json:"number_of_episodes,omitempty"`
	NumberOfSeasons  int    `json:"number_of_seasons,omitempty"`
	Status           string `json:"status,omitempty"`
	InProduction     bool   `json:"in_production,omitempty"`

	ShowSeasons `json:"seasons"`
	CreatedBy   `json:"created_by,omitempty"`
	Credits     `json:"credits,omitempty"`
}

type CreatedBy []struct {
	ID          int    `json:"id"`
	Name        string `json:"name"`
	ProfilePath string `json:"profile_path"`
}

type ShowSeasons []struct {
	ID           int    `json:"id"`
	AirDate      string `json:"air_date,omitempty"`
	EpisodeCount int    `json:"episode_count,omitempty"`
	PosterPath   string `json:"poster_path,omitempty"`
	SeasonNumber int    `json:"season_number,omitempty"`
}
