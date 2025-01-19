

export default class Constants {
  //后端服务器地址
  static readonly SERVER: string = 'http://192.168.1.3:9588';

  //新闻类型
  static readonly GET_NEWS_TYPE: string = 'news/getNewsType';


  static readonly GET_NEWS_LIST: string = 'news/getNewsList';

  static readonly UPLOAD_NEWS: string = 'news/addNews';


  static readonly UPLOAD_FILE: string = '/files/upload';


  static readonly IMAGE_PREFIX: string = '/images/';

  static readonly NEWS_EDIT_PAGE: string = 'pages/NewsEditPage'


  static readonly SERVER_CODE_SUCCESS: string = 'success';

  static readonly Y_OFF_SET_COEFFICIENT: number = 0.1;

  static readonly PAGE_SIZE: number = 10;

  static readonly CUSTOM_LAYOUT_HEIGHT: number = 70;


  static readonly GET_TAB_DATA_CURRENT_PAGE: number = 1;


  static readonly HTTP_CODE_200: number = 200;


  static readonly DELAY_ANIMATION_DURATION: number = 300;


  static readonly DELAY_TIME: number = 1000;


  static readonly ANIMATION_DURATION: number = 2000;


  static readonly HTTP_READ_TIMEOUT: number = 10000;


  static readonly CONTENT_MAX_LINE: number = 3;


  static readonly LIST_SPACE: number = 12;


  static readonly ITEM_IMG_SPACE: number = 8;


  static readonly TYPE_FONT_WEIGHT: number = 700;


  static readonly TITLE_FONT_WEIGHT: number = 500;


  static readonly DESC_FONT_WEIGHT: number = 400;


  static readonly TYPE_ASPECT_RATIO: number = 2;


  static readonly DESC_OPACITY: number = 0.6;


  static readonly FULL_PERCENT: string = '100%';


  static readonly DIVIDER_WIDTH: string = '90%';


  static readonly RELEASE_TITLE: string = '新闻发布';
}


export const enum RefreshConstant {
  DELAY_PULL_DOWN_REFRESH = 50,
  CLOSE_PULL_DOWN_REFRESH_TIME = 150,
  DELAY_SHRINK_ANIMATION_TIME = 500
}


export const enum RefreshState {
  DropDown = 0,
  Release = 1,
  Refreshing = 2,
  Success = 3,
  Fail = 4
}


export const enum PageState {
  Loading = 0,
  Success = 1,
  Fail = 2
}


export const enum UploadingState {
  COMPLETE = 'complete',
  FAIL = 'fail'
}


export const enum RequestMethod {
  POST = 'POST',
  GET = 'GET'
}

export const enum ContentType {
  JSON = 'application/json',
  FORM = 'multipart/form-data'
}