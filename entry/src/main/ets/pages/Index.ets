import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';
import { news_page } from './newspage'
import { Login } from './login'
import { taskpool } from '@kit.ArkTS'

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
          .fontSize(14)
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
    new ArticleClass('1', $r('app.media.tutorial_pic1'), 'Step1 开发入门:Hello World',
      '本篇教程实现了快速入门——一个用于了解和学习HarmonyOS的应用程序 。',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-HelloWorld'),
    new ArticleClass('2', $r('app.media.tutorial_pic2'), 'Step2 使用Swiper构建运营位',
      'Swiper组件提供滑动轮播显示的能力。Swiper本身是一个容器组件，当设置了多个子组件后，可以对这些子组件进行轮播显示。',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-SwiperBanner'),
    new ArticleClass('3', $r('app.media.tutorial_pic3'), 'Step3 创建Item视图',
      'Item定义子组件相关特征。相关组件支持使用条件渲染、循环渲染、懒加载等方式生成子组件。',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-BuildItem'),
    new ArticleClass('4', $r('app.media.tutorial_pic4'), 'Step4 网格和列表组件的使用',
      '网格和列表组件中，当Item达到一定数量，内容超过屏幕大小时，可以自动提供滚动功能，适合用于呈现同类数据类型或数据类型集',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-GridAndList'),
    new ArticleClass('5', $r('app.media.tutorial_pic5'), 'Step5 应用架构设计基础——MVVM框架',
      'ArkUI采取MVVM = Model + View + ViewModel模式，将数据与视图绑定在一起，数据更新时候会直接更新视图。',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-BasicArchitectureDesignPart1'),
    new ArticleClass('6', $r('app.media.tutorial_pic6'), 'Step6 应用架构设计基础——三层架构',
      'ArkWeb（方舟Web）提供了Web组件，用于在应用程序中显示Web页面内容，为开发者提供页面加载、页面交互、页面调试等能力。',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-BasicArchitectureDesignPart2'),
    new ArticleClass('7', $r('app.media.tutorial_pic7'), 'Step7 ArkWeb页面适配',
      '基于Web组件实现了快速入门案例中的课程学习界面，帮助开发者了解如何加载网络界面、本地界面以及如何进行网络权限的配置。',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-ArkwebPageAdaptation'),
    new ArticleClass('8', $r('app.media.tutorial_pic8'), 'Step8 通过结构数据构建页面',
      '在该教程中会根据对知识地图界面进行界面实现的分析以及相应的数据结构的设计，然后逐步实现知识地图中的两个界面。通过该章节，开发者可以了解到数据如何驱动UI更新。',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-DataDrivenUIUpdates'),
    new ArticleClass('9', $r('app.media.tutorial_pic9'), 'Step9 设置组件导航',
      '该教程会在“数据驱动UI更新”教程完成了知识地图相关界面开发的基础上，对代码进行修改，实现从知识地图页到知识地图详情页的组件路由导航，同时该教程中会讲解到Tabs的开发。',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-SettingUpComponentNavigation'),
    new ArticleClass('10', $r('app.media.tutorial_pic10'), 'Step10 原生智能：AI语音朗读',
      '为您的文章详情页添加文本转语音服务，朗读文章简介，手机在无网状态下系统应用无障碍（屏幕朗读）接入文本转语音能力，提供语音播报。',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-TTS'),
    new ArticleClass('11', $r('app.media.tutorial_pic11'), 'Step11 一次开发，多端部署',
      '通过对快速入门整体页面的分析，得出关键的界面适配点以及需要适配的关键组件，然后通过对关键适配点的逐步适配，完成整个应用的一多开发。',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-DevelopOnceDeployAnywhere'),
    new ArticleClass('12', $r('app.media.tutorial_pic12'), 'Step12 原生互联：分布式流转',
      '基于分布式流转相关能力，使得整个应用可以在不同设备间进行无缝的流转。该章节内容会涉及到流转的相关前提，如何进行流转的权限配置以及实现应用可流转。',
      'https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-DistributedFlow')
  ];

  build() {
    Column() {
      Text('入门教程')
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
                  params: new routerParams(item.webUrl)
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
