
import './NewsPage'
import { News } from './NewsPage';
import  './SettingsPage'
import { Settings } from './SettingsPage';

@Entry
@Component
struct BottomTab {
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
        News()
      }.tabBar(this.TabBuilder('新闻', 0))
      TabContent() {
        Settings()
      }.tabBar(this.TabBuilder('设置', 1))
    }

    .onChange((index) => {
      this.currentIndex = index;
    })
  }
}