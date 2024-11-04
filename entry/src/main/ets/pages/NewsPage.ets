import {webview} from '@kit.ArkWeb'

@Component
export struct News {
  controller:webview.WebviewController = new webview.WebviewController()
  build() {
    Column() {
      Web({src:'https://world.huanqiu.com/', controller:this.controller})
    }
  }
}