package tmdb

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func CastSearchHanlder(w http.ResponseWriter, req *http.Request) {
	userSearchString := req.PostForm.Get("userstring")
	fmt.Println("Query Params: ", userSearchString)

	castSearchurl := "https://api.themoviedb.org/3/movie"
	searchReq, _ := http.NewRequest("GET", castSearchurl, nil)
	searchReq.Header.Set("Content-Type", "application/json;charset=utf-8")

	castQuery := searchReq.URL.Query()
	castQuery.Add("append_to_response", "images,tagged_images,credits")
	castQuery.Add("language", "en-US")
	castQuery.Add("sort_by", "created_at.asc")

	if apiKey := os.Getenv("TMDBKEY"); apiKey != "" {
		castQuery.Add("api_key", apiKey)
	} else {
		castQuery.Add("api_key", "ee13e4da59356740b68c2e6966ff4856")
	}
	searchReq.URL.RawQuery = castQuery.Encode()

	res, _ := http.DefaultClient.Do(searchReq)
	defer res.Body.Close()

	body, _ := ioutil.ReadAll(res.Body)
	fmt.Println(res)
	fmt.Println(string(body))
	fmt.Fprint(w, string(body))
}
