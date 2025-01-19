import { router } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';

class routerParams {
  src:string = ''
}

//根据给定url，跳转到web页面
@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  @State params: routerParams = router.getParams() as routerParams
  @State src: string = this.params.src;
  build() {
    Column() {
      Web({ src: this.src, controller: this.controller})
    }
  }
}
