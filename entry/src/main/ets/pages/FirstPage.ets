
@Component
export struct  FirstPage{
  build()   {
  Column(){
    Text('首页')
      .fontSize(48)
      .fontWeight(700)
      .lineHeight(33)
      .width('100%')
      .textAlign(TextAlign.Start)
      .margin({left:16,bottom:30})
    ListItems()
    }
  }
}
@Component
struct ListItems {
  build() {
    Row(){
      Column(){
        Button('国际新闻')
          .onClick(()=>{

          })
          .fontSize(24)
          .margin({top:30,bottom:30})
        Button('体育新闻')
          .fontSize(24)
          .margin({top:30,bottom:30})
        Button('游戏新闻')
          .fontSize(24)
          .margin({top:30,bottom:30})
      }
    }
  }
}