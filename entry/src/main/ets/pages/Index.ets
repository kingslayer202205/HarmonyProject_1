import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';
import { news_page } from './newspage'
import { Login } from './login';

class ArticleClass {
  id: string = '';
  imageSrc: ResourceStr = '';
  title: string = '';
  brief: string = '';
  webUrl: string = '';

  constructor(id: string, imageSrc: ResourceStr, title: string, brief: string, webUrl: string) {
    this.id = id;
    this.imageSrc = imageSrc;
    this.title = title;
    this.brief = brief;
    this.webUrl = webUrl;
  }
}
const TAG = '[IndexPage]';
class routerParams {
  src:string
  constructor(str:string) {
    this.src = str
  }
}
@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private tabsController : TabsController = new TabsController();
  @Builder
  tabBarBuilder(title: string, targetIndex: number, selectedIcon: Resource, unselectIcon: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedIcon : unselectIcon)
        .width(24)
        .height(24)
      Text(title)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(10)
        .fontColor(this.currentIndex === targetIndex ? '#0A59F7' : 'rgba(0,0,0,0.60)')
        .textAlign(TextAlign.Center)
        .lineHeight(14)
        .fontWeight(500)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(targetIndex);
    })
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
      TabContent() {
        Column(){
          Scroll() {
            Column() {
              TutorialView()
            }
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
          .align(Alignment.TopStart)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F1F3F5')
      }
      .tabBar(this.tabBarBuilder('首页', 0, $r('app.media.ic_01_on'), $r('app.media.ic_01_off')))

      TabContent() {
        news_page();
      }
      .tabBar(this.tabBarBuilder('新闻', 1, $r('app.media.ic_01_on'), $r('app.media.ic_01_off')))

      TabContent() {
        Login();
      }
      .tabBar(this.tabBarBuilder('用户', 2, $r('app.media.ic_01_on'), $r('app.media.ic_01_off')))
    }
    .scrollable(false)
    .vertical(false)
    .divider({
      strokeWidth: 0.5,
      color: '#0D182431'
    })
    .backgroundColor('#F1F3F5')
    .padding({ top: 36, bottom: 28 })
  }
}

@Component
struct TutorialItem {
  @Prop tutorialItem: ArticleClass;
  controller: webview.WebviewController = new webview.WebviewController();
  build() {
    Row() {
      Column() {
        Text(this.tutorialItem.title)
          .height(19)
          .width('100%')
          .fontSize(20)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .fontWeight(400)
          .margin({ top: 4 })
        Text(this.tutorialItem.brief)
          .height(32)
          .width('100%')
          .fontSize(12)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(2)
          .fontWeight(400)
          .fontColor('rgba(0, 0, 0, 0.6)')
          .margin({ top: 5 })
      }
      .height('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ right: 12 })

      Image(this.tutorialItem.imageSrc)
        .height(64)
        .width(108)
        .objectFit(ImageFit.Cover)
        .borderRadius(16)
    }
    .width('100%')
    .height(88)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .padding(12)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct TutorialView {
  @State tutorialList: Array<ArticleClass> = [
    new ArticleClass('1', $r('app.media.ic_01_off'), 'HarmonyOS简介',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496599725471'),
    new ArticleClass('2', $r('app.media.ic_01_off'), 'DevEco Studio的使用',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717494752698457'),
    new ArticleClass('3', $r('app.media.ic_01_off'), 'ArkTS语法介绍',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717496870909384'),
    new ArticleClass('4', $r('app.media.ic_01_off'), '应用程序框架基础',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497122909477'),
    new ArticleClass('5', $r('app.media.ic_01_off'), '从简单的页面开始',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497398588123'),
    new ArticleClass('6', $r('app.media.ic_01_off'), '构建更加丰富的页面',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497640610394'),
    new ArticleClass('7', $r('app.media.ic_01_off'), '从网络获取数据',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717497918284399'),
    new ArticleClass('7', $r('app.media.ic_01_off'), '保存应用数据',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101717498132814493'),
    new ArticleClass('9', $r('app.media.ic_01_off'), '应用程序框架进阶',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101705071657237039'),
    new ArticleClass('10', $r('app.media.ic_01_off'), 'ArkUI进阶',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101705072791452043'),
    new ArticleClass('11', $r('app.media.ic_01_off'), '合理使用动画和转场',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101705081897917056'),
    new ArticleClass('12', $r('app.media.ic_01_off'), 'Web组件和WebView',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序。',
      'https://developer.huawei.com/consumer/cn/training/course/slightMooc/C101705083116217059'),
  ];

  build() {
    Column() {
      Text('鸿蒙开发教程')
        .fontColor('#182431')
        .fontSize(32)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Start)
        .padding({ left: 16 })
        .margin({ bottom: 8.5 })
      List({ space: 12 }) {
        ForEach(this.tutorialList, (item: ArticleClass) => {
          ListItem() {
            TutorialItem({ tutorialItem: item })
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/webPage',
                  params: new routerParams('')
                })
              })
          }
        }, (item: ArticleClass) => item.id)
      }
      .scrollBar(BarState.Off)
      .padding({ left: 16, right: 16 })
    }
    .margin({ top: 18 })
    .alignItems(HorizontalAlign.Start)
  }
}