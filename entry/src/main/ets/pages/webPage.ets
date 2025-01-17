import { router } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';

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
      // 组件创建时，加载www.example.com
      Web({ src: this.src, controller: this.controller})
    }
  }
}
