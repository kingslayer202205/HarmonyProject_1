

import Constants from '../common/constant/Constants';

//加载中
@Component
export default struct LoadingLayout {
  build() {
    Row() {
      Image($r('app.media.ic_pull_up_load'))
        .width($r('app.float.refresh_img_size'))
        .height($r('app.float.refresh_img_size'))
      Text($r('app.string.pull_up_load_text'))
        .margin({ left: $r('app.float.normal_padding') })
        .fontSize($r('app.float.title_font'))
        .textAlign(TextAlign.Center)
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.CUSTOM_LAYOUT_HEIGHT)
    .justifyContent(FlexAlign.Center)
  }
}