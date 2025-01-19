
import NewsTypeBean from './NewsTypeModel'
import ResponseResult from './ResponseResult';
import Constants from '../common/constant/Constants';
import { httpRequestGet } from '../common/tools/Http';

const DEFAULT_NEWS_TYPES: NewsTypeBean[] = [
  new NewsTypeBean(0, $r('app.string.tab_all')),
  new NewsTypeBean(1, $r('app.string.tab_domestic')),
  new NewsTypeBean(2, $r('app.string.tab_international')),
  new NewsTypeBean(3, $r('app.string.tab_fun')),
  new NewsTypeBean(4, $r('app.string.tab_military')),
  new NewsTypeBean(5, $r('app.string.tab_sports')),
  new NewsTypeBean(6, $r('app.string.tab_science'))
];

class NewsTypeViewModel {

  getNewsTypeList(): Promise<NewsTypeBean[]> {
    return new Promise((resolve: Function) => {
      let url = `${Constants.SERVER}/${Constants.GET_NEWS_TYPE}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === Constants.SERVER_CODE_SUCCESS) {
          resolve(data.data);
        } else {
          resolve(DEFAULT_NEWS_TYPES);
        }
      }).catch(() => {
        resolve(DEFAULT_NEWS_TYPES);
      });
    });
  }


  getDefaultTypeList(): NewsTypeBean[] {
    return DEFAULT_NEWS_TYPES;
  }
}

let newsTypeViewModel = new NewsTypeViewModel();

export default newsTypeViewModel as NewsTypeViewModel;