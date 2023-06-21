package rhttp

import (
	"fmt"

	"net/http"
	"time"
)

const maxRetries = 10

func Get(url string) (*http.Response, error) {
	var (
		resp *http.Response
		req  *http.Request
		err  error
	)

	for i := 0; i < maxRetries; i++ {
		//nolint:noctx // we don't need a context here
		req, err = http.NewRequest(http.MethodGet, url, http.NoBody)
		if err != nil {
			return resp, fmt.Errorf("error creating request: %w", err)
		}

		resp, err = http.DefaultClient.Do(req)
		if err != nil {
			fmt.Printf("Error: %s, Retrying in %d second(s)\n", err, i+1)
			time.Sleep(time.Second * time.Duration(i+1))

			continue
		}

		fmt.Printf("URL: %s, Status: %s\n", url, resp.Status)

		if resp.StatusCode >= http.StatusInternalServerError { // retry for 5xx errors
			fmt.Printf("Server error: %s, Retrying in %d second(s)\n", resp.Status, i+1)
			time.Sleep(time.Second * time.Duration(i+1))

			continue
		}

		return resp, nil
	}

	return resp, fmt.Errorf("max retries reached, last error: %w", err)
}
