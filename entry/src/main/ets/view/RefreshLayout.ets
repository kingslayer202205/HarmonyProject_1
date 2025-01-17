
import RefreshLoadingClass from '../viewmodel/RefreshLoadingClass';
import Constants from '../common/constant/Constants';

/**
 * The refresh layout component.
 */
@Component
export default struct RefreshLayout {
  @ObjectLink refreshLoadingClass: RefreshLoadingClass;

  build() {
    Row() {
      Image(this.refreshLoadingClass.imageSrc)
        .width($r('app.float.refresh_img_size'))
        .height($r('app.float.refresh_img_size'))

      Text(this.refreshLoadingClass.textValue)
        .margin({ left: $r('app.float.normal_padding') })
        .fontSize($r('app.float.title_font'))
        .textAlign(TextAlign.Center)
    }
    .clip(true)
    .width(Constants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
    .height(this.refreshLoadingClass.heightValue)
  }
}