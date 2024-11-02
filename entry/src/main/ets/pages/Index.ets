import { IntePage } from './InteNews';
import { SportPage } from './SportNews';
import { FirstPage } from './FirstPage';
import { GamePage } from './GameNews';

@Entry
@Component
struct BottomTabExample {
  private tabsController: TabsController = new TabsController();
  @State currentIndex: number = 0;

  @Builder TabBuilder(title: string, targetIndex: number) {
    Column() {
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      controller: this.tabsController
    }) {
      TabContent() {
        FirstPage()
        // 首页的内容
      }.tabBar(this.TabBuilder('首页', 0))
      TabContent() {
        IntePage()
        // 国际新闻页面的内容
      }.tabBar(this.TabBuilder('国际', 1))
      TabContent() {
        SportPage()
        // 体育新闻页面的内容
      }.tabBar(this.TabBuilder('体育', 2))
      TabContent(){
        GamePage()
        //游戏新闻页面的内容
      }.tabBar(this.TabBuilder('游戏',3))
    }

    .onChange((index) => {
      this.currentIndex = index;
    })
  }
}