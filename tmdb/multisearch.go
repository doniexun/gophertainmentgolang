package tmdb

import (
	"io/ioutil"
	"net/http"
	"os"
	"log"
	"bitbucket.org/daksh_sharma/gophertainment/model"
	"encoding/json"
)

func MultiSearchHanlder(w http.ResponseWriter, req *http.Request) {
	req.ParseForm()
	userSearchString := req.Form.Get("usersearchstring")
	//fmt.Println("Multi-Search Query Params: ", userSearchString)

	multiSearchUrl := "https://api.themoviedb.org/3/search/multi"
	searchReq, _ := http.NewRequest("GET", multiSearchUrl, nil)
	searchReq.Header.Set("Content-Type", "application/json;charset=utf-8")

	msQuery := searchReq.URL.Query()
	msQuery.Add("query", userSearchString)
	msQuery.Add("include_adult", "false")
	msQuery.Add("language", "en-US")
	msQuery.Add("sort_by", "created_at.asc")

	if apiKey := os.Getenv("TMDBKEY"); apiKey != "" {
		msQuery.Add("api_key", apiKey)
	} else {
		msQuery.Add("api_key", "ee13e4da59356740b68c2e6966ff4856")
	}
	searchReq.URL.RawQuery = msQuery.Encode()

	res, _ := http.DefaultClient.Do(searchReq)
	defer res.Body.Close()

	body, _ := ioutil.ReadAll(res.Body)
	var resData model.MultiSearchResult
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
