package tmdb

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"log"
	"encoding/json"
	"bitbucket.org/daksh_sharma/gophertainment/model"
)

func MovieSearchHanlder(w http.ResponseWriter, req *http.Request) {
	req.ParseForm()
	movieSearchString := req.Form.Get("moviesearchid")
	fmt.Println("Query Params: ", movieSearchString)

	movieSearchurl := "https://api.themoviedb.org/3/movie/" + movieSearchString
	searchReq, _ := http.NewRequest("GET", movieSearchurl, nil)
	searchReq.Header.Set("Content-Type", "application/json;charset=utf-8")

	movieQuery := searchReq.URL.Query()
	movieQuery.Add("append_to_response", "credits,images,videos,keywords")
	movieQuery.Add("language", "en-US")
	movieQuery.Add("sort_by", "created_at.asc")

	if apiKey := os.Getenv("TMDBKEY"); apiKey != "" {
		movieQuery.Add("api_key", apiKey)
	} else {
		movieQuery.Add("api_key", "ee13e4da59356740b68c2e6966ff4856")
	}
	searchReq.URL.RawQuery = movieQuery.Encode()

	res, _ := http.DefaultClient.Do(searchReq)
	defer res.Body.Close()

	body, _ := ioutil.ReadAll(res.Body)
	var resData model.Movie
	err := json.Unmarshal([]byte(body), &resData)
	if err != nil {
		log.Fatalln("ERROR: Unable to UnMarshal")
	}
	json, err := json.Marshal(resData)
	if err != nil {
		log.Fatalln("ERROR: Unable to Marshal resData")
	}

	w.Write(json)
}
