

import { http } from '@kit.NetworkKit';
import { NewsData } from '../../viewmodel/NewsData';
import ResponseResult from '../../viewmodel/ResponseResult';
import Constants, { ContentType } from '../constant/Constants';


export function httpRequestGet(url: string) {
  return httpRequest(url, http.RequestMethod.GET);
}


export function httpRequestPost(url: string, newsData: NewsData) {
  return httpRequest(url, http.RequestMethod.POST, newsData);
}


function httpRequest(url: string, method: http.RequestMethod, params?: NewsData): Promise<ResponseResult> {
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: method,
    readTimeout: Constants.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': ContentType.JSON
    },
    connectTimeout: Constants.HTTP_READ_TIMEOUT,
    extraData: params
  });
  let serverData = new ResponseResult();
  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === Constants.HTTP_CODE_200) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);
      if (resultJson.code === Constants.SERVER_CODE_SUCCESS) {
        serverData.data = resultJson.data;
      }
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      serverData.msg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
    }
    return serverData;
  }).catch(() => {
    serverData.msg = $r('app.string.http_error_message');
    return serverData;
  });
}