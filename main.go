package main

import (
	"bitbucket.org/daksh_sharma/gophertainment/tmdb"
	"fmt"
	"log"
	"net/http"
)

func main() {

	http.HandleFunc("/", handle)

	http.HandleFunc("/_ah/health", healthCheckHandler)

	http.HandleFunc("/search", tmdb.MultiSearchHanlder)
	http.HandleFunc("/movie", tmdb.MovieSearchHanlder)
	http.HandleFunc("/tvshow", tmdb.TVShowSearchHanlder)

	log.Print("Listening on port 8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func handle(w http.ResponseWriter, req *http.Request) {
	if req.URL.Path != "/" {
		http.NotFound(w, req)
		return
	}
	fmt.Fprint(w, "Hello world!")
}

func healthCheckHandler(w http.ResponseWriter, req *http.Request) {
	fmt.Fprint(w, "Health Check Looks A-Okay!")
}
