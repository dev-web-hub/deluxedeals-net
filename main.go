package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "CubeCast Web Service — OK")
	})

	http.ListenAndServe(":10000", nil)
}
