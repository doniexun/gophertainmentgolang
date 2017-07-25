package model

type Actors struct {
	EntityId
	Birthday     string `json:"birthday,omitempty"`
	Deathday     string `json:"deathday,omitempty"`
	Gender       int    `json:"gender,omitempty"`
	Homepage     string `json:"homepage,omitempty"`
	PlaceOfBirth string `json:"place_of_birth,omitempty"`
	ProfilePath  string `json:"profile_path,omitempty"`
}
