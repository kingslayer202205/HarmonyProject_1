import { router } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
class routerParams {
  src:string = ''
}
@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State params: routerParams = router.getParams() as routerParams
  @State src: string = this.params.src;
  build() {
    Column() {
      Text(this.src)
        .fontSize(20)
        .opacity(0.6)
      Button('back')
        .onClick(() => {
          router.back();
        })
      Button('loadUrl')
        .onClick(() => {
          try {
            // 点击按钮时，通过loadUrl，跳转到www.example1.com
            this.controller.loadUrl('https://developer.huawei.com/consumer/cn/forum/home?all=1');
          } catch (error) {
            let e: BusinessError = error as BusinessError;
            console.error(`ErrorCode: ${e.code},  Message: ${e.message}`);
          }
        })
      // 组件创建时，加载www.example.com
      Web({ src: 'https://developer.huawei.com/consumer/cn/forum/home?all=1', controller: this.controller})
    }
  }
}