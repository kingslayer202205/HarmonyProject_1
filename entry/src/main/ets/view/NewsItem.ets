
import { NewsData, NewsFile } from '../viewmodel/NewsData';
import Constants from '../common/constant/Constants';

//新闻项目
@Component
export default struct NewsItem {
  newsData: NewsData = new NewsData();

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_news'))
          .height($r('app.float.title_font'))
          .aspectRatio(Constants.TYPE_ASPECT_RATIO)
        Text(this.newsData?.title)
          .fontSize($r('app.float.title_font'))
          .fontColor($r('app.color.title_color'))
          .layoutWeight(1)
          .maxLines(1)
          .lineHeight($r('app.float.title_line_height'))
          .fontFamily($r('app.string.harmony_hei_ti_medium'))
          .margin({ left: $r('app.float.normal_padding') })
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontWeight(Constants.TITLE_FONT_WEIGHT)
      }
      .alignItems(VerticalAlign.Center)
      .width(Constants.FULL_PERCENT)

      Text(this.newsData?.content)
        .fontSize($r('app.float.desc_font'))
        .fontFamily($r('app.string.harmony_hei_ti'))
        .opacity(Constants.DESC_OPACITY)
        .fontColor($r('app.color.title_color'))
        .lineHeight($r('app.float.desc_line_height'))
        .width(Constants.FULL_PERCENT)
        .maxLines(Constants.CONTENT_MAX_LINE)
        .fontWeight(Constants.DESC_FONT_WEIGHT)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Row({ space: Constants.ITEM_IMG_SPACE }) {
        ForEach((this.newsData.imagesUrl), (itemImg: NewsFile) => {
          Image(Constants.SERVER + itemImg?.url)
            .height(Constants.FULL_PERCENT)
            .aspectRatio(1)
            .objectFit(ImageFit.Cover)
            .borderRadius($r('app.float.item_img_border_radius'))
        }, (itemImg: NewsFile) => JSON.stringify(itemImg))
      }
      .clip(true)
      .width(Constants.FULL_PERCENT)
      .height($r('app.float.item_img_size'))
      .margin({ top: $r('app.float.common_padding') })

      Text(this.newsData?.source)
        .fontSize($r('app.float.source_font'))
        .fontColor($r('app.color.fontColor_text2'))
        .width(Constants.FULL_PERCENT)
        .margin({ top: $r('app.float.normal_padding') })
    }
    .padding($r('app.float.common_padding'))
  }
}