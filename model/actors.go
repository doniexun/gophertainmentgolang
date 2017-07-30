package model

type Actors struct {
	ID           int    `json:"id"`
	Name         string `json:"name,omitempty"`
	Biography    string `json:"biography,omitempty"`
	Birthday     string `json:"birthday,omitempty"`
	Deathday     string `json:"deathday,omitempty"`
	Gender       int    `json:"gender,omitempty"`
	Homepage     string `json:"homepage,omitempty"`
	PlaceOfBirth string `json:"place_of_birth,omitempty"`
	ProfilePath  string `json:"profile_path,omitempty"`

	Credits `json:"credits,omitempty"`
	Images  `json:"images,omitempty"`
}

type Images struct {
	Profiles []struct {
		FilePath string `json:"file_path,omitempty"`
	} `json:"profiles,omitempty"`
}
