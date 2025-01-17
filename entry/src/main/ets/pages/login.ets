import PreferenceModel, { Account } from '../model/PreferenceModel';
import promptAction from '@ohos.promptAction';
import { taskpool } from '@kit.ArkTS'


@Concurrent
function Logout(isLogin:boolean):void {
  PreferenceModel.deletePreferences();


}
@Component
export struct Login {
  @State account: Account = new Account();
  @State isLogin:boolean = false
  build() {
    Column({space: 10}){

      if(this.isLogin == true)
      {
        //假如已登录，显示用户名和欢迎信息
        Text('欢迎你')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .margin({ bottom: 30 })

        Text(this.account.account)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .margin({ bottom: 20 })

        Text('用户信息已保存')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .margin({ bottom: 40 })

        Text('退出登录')
          .fontColor('#017DFF')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .margin({ bottom: 20 })
          .onClick(() => {
            //点击退出登录，在本地删除账号信息，更新登录状态
            PreferenceModel.deletePreferences();
            this.isLogin = false;
          })

      }
      else {

        //显示登录页面
        Text('用户登录')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor($r('sys.color.font_primary'))

        TextInput({ placeholder: '用户名' })
          .maxLength(11)
          .type(InputType.USER_NAME)
          .onChange((value: string) => {
            this.account.account = value;
          })
          .backgroundColor('#F0F2F4')
          .border({ color: '#ff008aff', width: '100%' })
        TextInput({ placeholder: '密码' })
          .type(InputType.Password)
          .onChange((value: string) => {
            this.account.password = value;
          })
          .backgroundColor('#F0F2F4')
          .border({ color: '#ff008aff', width: '100%' })

        Button('登录')
          .onClick(() => {
            //检查输入是否为空
            if (this.account.account != '' && this.account.password != '') {
              this.isLogin = true;
              PreferenceModel.writeData(this.account);

            } else {
              promptAction.showToast({
                message: '请输入账号密码！',
                duration: 2000,
              });

            }
          }
          )
          .width('100%')
          .margin({ top: 50, bottom: 10 })
        Text('未注册将自动创建账号')
          .fontColor('#017DFF')


      }

    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(20)
    .backgroundColor('#F1F3F5')

  }

  async aboutToAppear() {
    //每次打开此页面，从本地获取账号数据
    await PreferenceModel.getPreferencesFromStorage();
    PreferenceModel.getAccountData().then((saved:Account)=>{
      if(saved){
        this.isLogin = true;
        this.account = saved;
      }
    });
  }


}