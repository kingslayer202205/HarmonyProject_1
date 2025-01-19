import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';
import { news_page } from './NewsPage'
import { Login } from './login'
import { taskpool } from '@kit.ArkTS'
import { routerParams } from '../common/constant/router'

//存储列表项的相关信息
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

//加载web页面
@Concurrent
function WebLoad(url:string): void {
    router.pushUrl({
      url:'pages/webPage',
      params: new routerParams(url)
    })
}

async function ConWebLoad(url:string){
  try{
    let task:taskpool.Task = new taskpool.Task(WebLoad,url);
    let result = await taskpool.execute(task);
    console.log("taskpool result is "+ result);
  }
  catch (e){
    console.error("Error Happened in taskpool: " + e);
  }
}

//构建主页面
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
      try {
        this.currentIndex = targetIndex;
        this.tabsController.changeIndex(targetIndex);
      }
      catch (e){
        console.error("change index error :" + e);
      }

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
        news_page();  //新闻阅览页面
      }
      .tabBar(this.tabBarBuilder('新闻', 1, $r('app.media.ic_01_on'), $r('app.media.ic_01_off')))

      TabContent() {
        Login();  //登录页面
      }
      .tabBar(this.tabBarBuilder('用户', 2, $r('app.media.ic_01_on'), $r('app.media.ic_01_off')))
    }

    .scrollable(true)
    .vertical(false)
    .divider({
      strokeWidth: 0.5,
      color: '#0D182431'
    })
    .backgroundColor('#F1F3F5')
    .padding({ top: 36, bottom: 28 })
  }
}

//列表项的结构
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
          .fontSize(18)
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


//列表项显示的具体内容
@Component
struct TutorialView {
  @State tutorialList: Array<ArticleClass> = [
    new ArticleClass('1', $r('app.media.tutorial_pic1'), '应用开发导读',
      '应用开发文档用于指导开发者通过HarmonyOS SDK提供的开放能力完成应用开发。在使用应用开发文档前，推荐您通过知识地图了解应用开发完整旅程。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/application-dev-guide-V5'),
    new ArticleClass('2', $r('app.media.tutorial_pic2'), '快速入门',
      '本文档适用于HarmonyOS应用开发的初学者。通过构建一个简单的具有页面跳转/返回功能的应用，快速了解工程目录的主要文件，熟悉HarmonyOS应用开发流程。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/quick-start-V5'),
    new ArticleClass('3', $r('app.media.tutorial_pic3'), '开发基础知识',
      '在基于Stage模型开发应用之前，开发者需要了解应用的设计机制、应用程序包结构等基础知识。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/development-fundamentals-V5'),
    new ArticleClass('4', $r('app.media.tutorial_pic4'), '资源分类与访问',
      '应用开发过程中，经常需要用到颜色、字体、间距、图标等资源，在不同的设备或配置中，这些资源的值可能不同。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/resource-categories-and-access-V5'),
    new ArticleClass('5', $r('app.media.tutorial_pic5'), '学习ArkTS语言',
      'ArkTS是HarmonyOS优选的主力应用开发语言。ArkTS围绕应用开发在TypeScript（简称TS）生态基础上做了进一步扩展，保持了TS的基本风格，同时通过规范定义强化开发期静态检查和分析，提升程序执行稳定性和性能。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/learning-arkts-V5'),
    new ArticleClass('6', $r('app.media.tutorial_pic6'), '术语',
      '鸿蒙软件开发的必备术语',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/glossary-V5'),
    new ArticleClass('7', $r('app.media.tutorial_pic7'), '应用开发准备',
      '在开始应用开发前，需要先完成以下准备工作。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/application-dev-overview-V5'),
    new ArticleClass('8', $r('app.media.tutorial_pic8'), 'Ability Kit（程序框架服务）',
      'Ability Kit（程序框架服务）提供了应用程序开发和运行的应用模型，是系统为开发者提供的应用程序所需能力的抽象提炼，它提供了应用程序必备的组件和运行机制。有了应用模型，开发者可以基于一套统一的模型进行应用开发，使应用开发更简单、高效。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ability-kit-V5'),
    new ArticleClass('9', $r('app.media.tutorial_pic9'), 'ArkTS（方舟编程语言）',
      'ArkTS是HarmonyOS应用开发的官方高级语言。ArkTS提供了声明式UI范式、状态管理、渲染控制等相应的能力，让开发者能够以更简洁、更自然的方式开发应用。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-V5'),
    new ArticleClass('10', $r('app.media.tutorial_pic10'), 'ArkUI（方舟UI框架）',
      'ArkUI（方舟UI框架）为应用的UI开发提供了完整的基础设施，包括简洁的UI语法、丰富的UI功能（组件、布局、动画以及交互事件），以及实时界面预览工具等，可以支持开发者进行可视化界面开发。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkui-V5'),
    new ArticleClass('11', $r('app.media.tutorial_pic11'), 'ArkWeb（方舟Web）',
      'ArkWeb（方舟Web）提供了Web组件，用于在应用程序中显示Web页面内容。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkweb-V5'),
    new ArticleClass('12', $r('app.media.tutorial_pic12'), 'Core File Kit（文件基础服务）',
      'Core File Kit（文件基础服务）为开发者提供一套访问和管理应用文件和用户文件的能力。帮助用户更高效地管理、查找和备份各类文件，使用户能够轻松应对各种文件管理的需求。',
      'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/core-file-kit-V5')
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
                //this.opacity(0.6)
                try {
                  WebLoad(item.webUrl);
                }
                catch (e){
                  console.error("WebPage load error:" + e);
                }

              })

          }

        }, (item: ArticleClass) => item.id)
      }
      .scrollBar(BarState.Off)
      .padding({ left: 16, right: 16 })

    }
    .margin({ top: 18 })
    .alignItems(HorizontalAlign.Start)
    .transition(TransitionEffect.SLIDE.animation({curve: Curve.Ease}))
  }
}
