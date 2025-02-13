
import { router } from '@kit.ArkUI';
import Constants from '../common/constant/Constants';
import { fileSelect, fileUpload } from '../common/tools/File';
import { NewsFile, NewsData } from '../viewmodel/NewsData';
import NewsViewModel from '../viewmodel/NewsViewModel';
import { showToast } from '../common/tools/Toast';
import UploadingLayout from '../view/UploadingLayout';
import ResponseResult from '../viewmodel/ResponseResult';
import { GlobalContext } from '../viewmodel/GlobalContext';


@Entry
@Component
struct NewsEditPage {
  title: string = '';
  content: string = '';
  @State imageUri: string = '';
  @State isUploading: boolean = false;

  selectImage() {
    fileSelect().then((uri: string) => {
      this.imageUri = uri || '';
    });
  }

  //发布新闻的逻辑
  uploadNewsData() {
    if (this.title === '') {
      showToast($r('app.string.prompt_no_title'));
      return;
    }
    if (this.content === '') {
      showToast($r('app.string.prompt_no_content'));
      return;
    }
    if (this.imageUri === '') {
      showToast($r('app.string.prompt_no_file'));
      return;
    }
    this.isUploading = true;
    let serverData = fileUpload(getContext(this), this.imageUri);
    serverData.then((data: ResponseResult) => {
      let imageUrl = data.data;
      let newsFile = new NewsFile();
      newsFile.id = 0;
      newsFile.url = imageUrl;
      newsFile.type = 0;
      newsFile.newsId = 0;
      let newsData: NewsData = new NewsData();
      newsData.title = this.title;
      newsData.content = this.content;
      newsData.imagesUrl = [newsFile];
      NewsViewModel.uploadNews(newsData).then(() => {
        this.isUploading = false;
        GlobalContext.getContext().setObject('isBackRouter', true);
        router.back();
      }).catch(() => {
        this.isUploading = false;
        showToast($r('app.string.upload_error_message'));
      });
    }).catch(() => {
      this.isUploading = false;
      showToast($r('app.string.upload_error_message'));
    });
  }

  //构建新闻发布页
  build() {
    Stack() {
      Navigation() {
        Column() {
          Column() {
            TextInput({ placeholder: $r('app.string.title_default_text') })
              .fontSize($r('app.float.title_font'))
              .placeholderFont({ size: $r('app.float.title_font') })
              .margin({ top: $r('app.float.common_padding') })
              .fontColor($r('app.color.title_color'))
              .backgroundColor(Color.White)
              .onChange((value: string) => {
                this.title = value;
              })
              .width(Constants.FULL_PERCENT)
              .height($r('app.float.input_height'))
            Divider()
              .opacity($r('app.float.divider_opacity'))
              .color($r('app.color.title_color'))
              .width(Constants.DIVIDER_WIDTH)
            TextArea({ placeholder: $r('app.string.content_default_text') })
              .placeholderFont({ size: $r('app.float.title_font') })
              .fontColor($r('app.color.title_color'))
              .height($r('app.float.area_height'))
              .fontSize($r('app.float.title_font'))
              .margin({ top: $r('app.float.normal_padding') })
              .backgroundColor(Color.White)
              .onChange((value: string) => {
                this.content = value;
              })
            Scroll() {
              Row() {
                Image(this.imageUri ? this.imageUri : $r('app.media.ic_add_pic'))
                  .width($r('app.float.img_size'))
                  .height($r('app.float.img_size'))
                  .objectFit(ImageFit.Cover)
                  .onClick(() => this.selectImage())
              }
              .padding($r('app.float.common_padding'))
            }
            .width(Constants.FULL_PERCENT)
            .scrollable(ScrollDirection.Horizontal)
            .align(Alignment.Start)
          }
          .borderRadius($r('app.float.edit_view_radius'))
          .backgroundColor(Color.White)
          .width(Constants.FULL_PERCENT)

          Button($r('app.string.release_btn'))
            .fontSize($r('app.float.title_font'))
            .height($r('app.float.release_btn_height'))
            .width($r('app.float.release_btn_width'))
            .margin({ bottom: $r('app.float.common_padding') })
            .onClick(() => this.uploadNewsData())
        }
        .padding({
          left: $r('app.float.common_padding'),
          right: $r('app.float.common_padding'),
          bottom: $r('app.float.common_padding')
        })
        .height(Constants.FULL_PERCENT)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .height(Constants.FULL_PERCENT)
      .title(Constants.RELEASE_TITLE)
      .titleMode(NavigationTitleMode.Mini)
      .backgroundColor($r('app.color.listColor'))

      if (this.isUploading) {
        UploadingLayout()
      }
    }
  }
}

