package model

type Credits struct {
	Cast []struct {
		ID          int    `json:"id"`
		Name        string `json:"name,omitempty"`
		Title       string `json:"title,omitempty"`
		CastID      int    `json:"cast_id,omitempty"`
		Character   string `json:"character,omitempty"`
		CreditID    string `json:"credit_id"`
		Gender      int    `json:"gender,omitempty"`
		Order       int    `json:"order,omitempty"`
		ProfilePath string `json:"profile_path,omitempty"`
		PosterPath  string `json:"poster_path,omitempty"`
		ReleaseDate string `json:"release_date,omitempty"`
	} `json:"cast,omitempty"`
	Crew []struct {
		ID          int    `json:"id"`
		Name        string `json:"name,omitempty"`
		Title       string `json:"title,omitempty"`
		CreditID    string `json:"credit_id,omitempty"`
		Department  string `json:"department,omitempty"`
		Gender      int    `json:"gender,omitempty"`
		Job         string `json:"job,omitempty"`
		ProfilePath string `json:"profile_path,omitempty"`
		PosterPath  string `json:"poster_path,omitempty"`
	} `json:"crew,omitempty"`
}
