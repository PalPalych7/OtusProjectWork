//go:build integration || ignore || (тест && ignore) || только || при || поднятой || базе || и || запущенном || основном || сервисе
// +build integration ignore тест,ignore только при поднятой базе и запущенном основном сервисе

package internalhttp

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"testing"
	"time"

	"github.com/stretchr/testify/require"
)

func TestHTTP(t *testing.T) {
	t.Run("main", func(t *testing.T) {
		client := http.Client{
			Timeout: time.Second * 5,
		}
		myHTTP := "http://127.0.0.2:5000/"
		ctx := context.Background()

		// добавление баннера к слоту
		reqBody1 := SlotBanner{1, 7}
		fmt.Println("reqBody=", reqBody1)
		bodyRaw1, errM1 := json.Marshal(reqBody1)
		require.NoError(t, errM1)
		req1, err1 := http.NewRequestWithContext(ctx, http.MethodPost, myHTTP+"AddBannerSlot", bytes.NewBuffer(bodyRaw1))
		require.NoError(t, err1)
		resp1, errResp1 := client.Do(req1) //nolint
		require.NoError(t, errResp1)
		defer resp1.Body.Close()
		bodyBytes1, errrr1 := ioutil.ReadAll(resp1.Body)
		require.NoError(t, errrr1)
		require.Empty(t, bodyBytes1)

		// удаление баннера со слота
		reqBody2 := SlotBanner{1, 7}
		fmt.Println("reqBody=", reqBody2)
		bodyRaw2, errM2 := json.Marshal(reqBody2)
		require.NoError(t, errM2)
		req2, err2 := http.NewRequestWithContext(ctx, http.MethodPost, myHTTP+"DelBannerSlot", bytes.NewBuffer(bodyRaw2))
		require.NoError(t, err2)
		resp2, errResp2 := client.Do(req2) //nolint
		require.NoError(t, errResp2)
		fmt.Println(resp2, errResp2)

		// увеличить счётчик
		reqBody3 := ForBannerClick{1, 4, 1}
		fmt.Println("reqBody=", reqBody3)
		bodyRaw3, errM3 := json.Marshal(reqBody3)
		require.NoError(t, errM3)
		req3, err3 := http.NewRequestWithContext(ctx, http.MethodPost, myHTTP+"BannerClick", bytes.NewBuffer(bodyRaw3))
		require.NoError(t, err3)
		resp3, errResp3 := client.Do(req3) //nolint
		require.NoError(t, errResp3)
		fmt.Println(resp3, errResp3)

		// получение баннера для показа
		reqBody := ForGetBanner{1, 1}
		fmt.Println("reqBody=", reqBody)
		bodyRaw, errM := json.Marshal(reqBody)
		fmt.Println("bodyRaw=", bodyRaw)
		require.NoError(t, errM)
		req, err := http.NewRequestWithContext(ctx, http.MethodPost, myHTTP+"GetBannerForSlot", bytes.NewBuffer(bodyRaw))
		fmt.Println("req=", req)
		require.NoError(t, err)
		resp, errResp := client.Do(req) //nolint
		require.NoError(t, errResp)
		fmt.Println(resp, errResp)
		defer resp.Body.Close()
		bodyBytes, errrr := ioutil.ReadAll(resp.Body)
		fmt.Println(bodyBytes, errrr)
		require.NoError(t, errrr)
		var bannerId int
		errUnm := json.Unmarshal(bodyBytes, &bannerId)
		fmt.Println(errUnm, bannerId)
		require.NoError(t, errUnm)
	})
}