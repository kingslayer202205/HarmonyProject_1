import { preferences } from '@kit.ArkData';
import Account from './AccountModel'

let context = getContext(this);
let preference:preferences.Preferences;
let preferenceTemp:preferences.Preferences;

class PreferenceModel {
  private accountData:Account = new Account();

  async getDataFromStorage(){
    preference = await preferences.getPreferences(context,'MyStore');
  }

  async deleteData(){
    await preferences.deletePreferences(context,'MyStore');
    preference = preferenceTemp
  }

  async putData(account:Account){
    if(!preference)
    {
      await this.getDataFromStorage()
    }

    await preference.put('account',JSON.stringify(account));
    await preference.flush();
  }

  async getData(){
    let account = '';
    if(!preference){
      await this.getDataFromStorage()
    }

    account = (await preference.get('account','')).toString();
    if (account === ''){
      return;
    }
    return JSON.parse(account)
  }

  async getAccountData(){
    this.accountData = await this.getData()
    return this.accountData;
  }

  writeData(account:Account){
    this.putData(account);

  }
}

export default new PreferenceModel();