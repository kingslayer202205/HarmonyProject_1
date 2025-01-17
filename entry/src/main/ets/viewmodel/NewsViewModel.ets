

import { NewsData } from './NewsData';
import ResponseResult from './ResponseResult';
import Constants from '../common/constant/Constants';
import { httpRequestGet, httpRequestPost } from '../common/utils/HttpUtil';
import Logger from '../common/utils/Logger';

class NewsViewModel {
  /**
   * Get news type list from server.
   *
   * @return NewsData[] newsDataList
   */
  getNewsList(currentPage: number, pageSize: number): Promise<NewsData[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${Constants.SERVER}/${Constants.GET_NEWS_LIST}`;
      url += '?currentPage=' + currentPage + '&pageSize=' + pageSize;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === Constants.SERVER_CODE_SUCCESS) {
          resolve(data.data);
        } else {
          Logger.error('getNewsList failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getNewsList failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  /**
   * Upload news data.
   *
   * @param newsData
   * @returns NewsData[] newsDataList
   */
  uploadNews(newsData: NewsData): Promise<NewsData[]> {
    return new Promise((resolve: Function, reject: Function) => {
      let url = `${Constants.SERVER}/${Constants.UPLOAD_NEWS}`;
      httpRequestPost(url, newsData).then((result: ResponseResult) => {
        if (result && result.code === Constants.SERVER_CODE_SUCCESS) {
          resolve(result.data);
        } else {
          reject($r('app.string.upload_error_message'));
        }
      }).catch((err: Error) => {
        Logger.error('uploadNews failed', JSON.stringify(err));
        reject($r('app.string.upload_error_message'));
      });
    });
  }
}

let newsViewModel = new NewsViewModel();

export default newsViewModel as NewsViewModel;