package model

type EntityId struct {
	ID            int    `json:"id"`
	MediaType     string `json:"media_type,omitempty"`
	Title         string `json:"title,omitempty"`
	Name          string `json:"name,omitempty"`
	OriginalName  string `json:"original_name,omitempty"`
	OriginalTitle string `json:"original_title,omitempty"`
	Overview      string `json:"overview,omitempty"`
	Biography     string `json:"biography,omitempty"`
	Popularity    string `json:"popularity,omitempty"`
}

type EntityPosterPath struct {
	PosterPath string `json:"poster_path,omitempty"`
}

type EntityBackdropPath struct {
	BackdropPath string `json:"backdrop_path,omitempty"`
}

type EntityProfilePath struct {
	ProfilePath string `json:"profile_path,omitempty"`
}

type EntityHomePage struct {
	Homepage string `json:"homepage,omitempty"`
}
