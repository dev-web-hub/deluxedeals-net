package main

import (
    "net/http"
    "log"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        w.Write([]byte("DeluxeDeals Root"))
    })

    http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
        w.Write([]byte("DeluxeDeals Web Service — OK"))
    })

    log.Println("🚀 DeluxeDeals Web Service running on :10000")
    http.ListenAndServe(":10000", nil)
}
