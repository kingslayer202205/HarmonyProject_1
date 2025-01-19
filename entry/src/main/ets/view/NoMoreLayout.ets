

//没有更多数据
import Constants from '../common/constant/Constants';

@Component
export default struct NoMoreLayout {
  build() {
    Row() {
      Text($r('app.string.prompt_message'))
        .margin({ left: $r('app.float.normal_padding') })
        .fontSize($r('app.float.title_font'))
        .textAlign(TextAlign.Center)
    }
    .width(Constants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
    .height(Constants.CUSTOM_LAYOUT_HEIGHT)
  }
}