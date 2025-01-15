
import Constants from '../common/constant/Constants';
import NewsList from '../view/NewsList';
import { router } from '@kit.ArkUI';
import NewsTypeViewModel from '../viewmodel/NewsTypeViewModel';
import NewsTypeBean from '../viewmodel/NewsTypeModel';
import { GlobalContext } from '../viewmodel/GlobalContext';

@Component
export struct news_page {
  @State tabBarArray: NewsTypeBean[] = NewsTypeViewModel.getDefaultTypeList();
  @State currentIndex: number = 0;

  @Builder TabBuilder(index: number) {
    Column() {
      Text(this.tabBarArray[index].name)
        .height(Constants.FULL_PERCENT)
        .fontSize(this.currentIndex === index ? $r('app.float.bar_selected_font') : $r('app.float.bar_normal_font'))
        .fontWeight(this.currentIndex === index ? Constants.TYPE_FONT_WEIGHT : Constants.DESC_FONT_WEIGHT)
        .fontColor($r('app.color.title_color'))
    }
    .padding({ left: $r('app.float.normal_padding'), right: $r('app.float.normal_padding') })
    .margin({
      left: index === 0 ? $r('app.float.common_padding') : 0,
      right: index === this.tabBarArray.length - 1 ? $r('app.float.common_padding') : 0
    })
  }

  aboutToAppear() {

    NewsTypeViewModel.getNewsTypeList().then((typeList: NewsTypeBean[]) => {
      this.tabBarArray = typeList;
    });
  }

  onPageShow() {
    if (GlobalContext.getContext().getObject('isBackRouter') === true) {
      GlobalContext.getContext().setObject('isBackRouter', false);
      let tempIndex = this.currentIndex;
      this.currentIndex = -1;
      this.currentIndex = tempIndex;
    }
  }

  build() {
    Stack() {
      Tabs() {
        ForEach(this.tabBarArray, (tabsItem: NewsTypeBean, index?: number) => {
          TabContent() {
            NewsList({ index, currentIndex: $currentIndex })
          }
          .tabBar(this.TabBuilder(tabsItem.id))
        }, (tabsItem: NewsTypeBean) => JSON.stringify(tabsItem));
      }
      .barHeight($r('app.float.nav_height'))
      .height(Constants.FULL_PERCENT)
      .barMode(BarMode.Scrollable)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .vertical(false)

      Image($r('app.media.ic_add'))
        .width($r('app.float.btn_size'))
        .height($r('app.float.btn_size'))
        .margin({ bottom: $r('app.float.btn_margin'), right: $r('app.float.btn_margin') })
        .onClick(() => {
          router.pushUrl({ url: Constants.NEWS_EDIT_PAGE });
        })
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .alignContent(Alignment.BottomEnd)
    .backgroundColor($r('app.color.listColor'))
  }
}