package tmdb

import (
	"bitbucket.org/daksh_sharma/gophertainment/model"
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

func TVShowSearchHanlder(w http.ResponseWriter, req *http.Request) {
	req.ParseForm()
	tvshowSearchId := req.Form.Get("tvshowsearchid")

	tvshowSearchurl := "https://api.themoviedb.org/3/tv/" + tvshowSearchId
	searchReq, _ := http.NewRequest("GET", tvshowSearchurl, nil)
	searchReq.Header.Set("Content-Type", "application/json;charset=utf-8")

	tvQuery := searchReq.URL.Query()
	tvQuery.Add("append_to_response", "credits,images,videos")
	tvQuery.Add("language", "en-US")
	tvQuery.Add("sort_by", "created_at.asc")

	if apiKey := os.Getenv("TMDBKEY"); apiKey != "" {
		tvQuery.Add("api_key", apiKey)
	} else {
		tvQuery.Add("api_key", "ee13e4da59356740b68c2e6966ff4856")
	}
	searchReq.URL.RawQuery = tvQuery.Encode()

	res, _ := http.DefaultClient.Do(searchReq)
	defer res.Body.Close()

	body, _ := ioutil.ReadAll(res.Body)
	var resData model.TvShow
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
