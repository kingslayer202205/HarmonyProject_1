import { webview } from '@kit.ArkWeb';


@Component
export struct IntePage {
  controller: webview.WebviewController = new webview.WebviewController()
  build() {
    Column() {
      Web({ src: 'www.example.com', controller: this.controller })
    }
  }
}