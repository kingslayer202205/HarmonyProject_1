

//存储新闻数据
export class NewsData {

  title: string = '';


  content: string = '';


  imagesUrl: Array<NewsFile> = [new NewsFile()];

  source: string = '';
}


export class NewsFile {

  id: number = 0;


  url:  | Object | ArrayBuffer = '';


  type: number = 0;


  newsId: number = 0;
}

