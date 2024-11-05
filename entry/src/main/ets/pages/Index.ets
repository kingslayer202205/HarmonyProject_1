

import {webview} from '@kit.ArkWeb'
import { Login } from './LoginPage';

@Entry
@Component
struct BottomTab {
  private tabsController: TabsController = new TabsController();
  @State currentIndex: number = 0;
  controller: webview.WebviewController = new webview.WebviewController()
  onBackPress(){
    if(this.controller.accessStep(-1)) {
      this.controller.backward()
      return true;
    }

   return false;
  }

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
        Web({ src: 'https://world.huanqiu.com/', controller: this.controller })
      }.tabBar(this.TabBuilder('新闻', 0))
      TabContent() {
        Login()
      }.tabBar(this.TabBuilder('设置', 1))
    }

    .onChange((index) => {
      this.currentIndex = index;
    })
  }
}

