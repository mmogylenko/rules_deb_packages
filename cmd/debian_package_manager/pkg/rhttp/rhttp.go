package rhttp

import (
	"fmt"

	_http "net/http"
	"time"
)

func Get(url string) (*_http.Response, error) {
	retry := 0
do:
	//nolint:noctx // we don't need a context here
	req, err := _http.NewRequest(_http.MethodGet, url, _http.NoBody)

	if err != nil {
		return nil, err
	}

	resp, err := _http.DefaultClient.Do(req)

	if err != nil {
		return nil, err
	}

	if err == nil {
		fmt.Printf("URL: %s, Status: %s\n", url, resp.Status)

		if resp.StatusCode == _http.StatusGatewayTimeout && retry < 10 {
			fmt.Printf("Retrying: %s\n", url)
			retry++
			time.Sleep(time.Second * time.Duration(retry))

			goto do
		}
	} else {
		fmt.Printf("URL: %s, Status: %s\n", url, resp.Status)
	}

	return resp, err
}
