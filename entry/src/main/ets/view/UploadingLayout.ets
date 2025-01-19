

import Constants from '../common/constant/Constants';


//上传中
@Component
export default struct UploadingLayout {

  build() {
    Column() {
      Image($r('app.media.ic_pull_up_load'))
        .width($r('app.float.btn_size'))
        .height($r('app.float.btn_size'))
      Text($r('app.string.uploading_text'))
        .margin({ top: $r('app.float.common_padding') })
        .fontSize($r('app.float.title_font'))
        .fontColor($r('app.color.title_color'))
        .textAlign(TextAlign.Center)
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
  }
}