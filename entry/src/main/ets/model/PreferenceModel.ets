import { promptAction } from '@kit.ArkUI';
import { preferences } from '@kit.ArkData';
import Logger from '../common/utils/Logger';
import CommonConstants from '../common/constant/CommonConstants';


let context = getContext(this);
let preference: preferences.Preferences;
let preferenceTemp: preferences.Preferences;

export class Account {
  account: string = '';
  password: string = '';
}

class PreferenceModel {
  private accountData:Account = new Account();


  async getPreferencesFromStorage() {
    try {
      preference = await preferences.getPreferences(context, CommonConstants.PREFERENCES_NAME);
    } catch (err) {
      Logger.error(CommonConstants.TAG, `Failed to get preferences, Cause: ${err}`);
    }
  }


  async deletePreferences() {
    try {
      await preferences.deletePreferences(context, CommonConstants.PREFERENCES_NAME);
    } catch(err) {
      Logger.error(CommonConstants.TAG, `Failed to delete preferences, Cause: ${err}`);
    };
    preference = preferenceTemp;
    this.showToastMessage($r('app.string.delete_success_msg'));
  }


  async putPreference(account:Account) {
    if (!preference) {
      await this.getPreferencesFromStorage();
    }
    try {
      await preference.put(CommonConstants.KEY_NAME, JSON.stringify(account));
    } catch (err) {
      Logger.error(CommonConstants.TAG, `Failed to put value, Cause: ${err}`);
    }
    // Store the Preference instance in the preference persistence file
    await preference.flush();
  }

  async getPreference() {
    let account = '';
    if (!preference) {
      await this.getPreferencesFromStorage();
    }
    try {
      account = (await preference.get(CommonConstants.KEY_NAME, '')).toString();
    } catch (err) {
      Logger.error(CommonConstants.TAG, `Failed to get value, Cause: ${err}`);
    }
    // If the data is empty, a message is displayed indicating that data needs to be written.
    if (account === '') {
      this.showToastMessage($r('app.string.data_is_null_msg'));
      return;
    }
    this.showToastMessage($r('app.string.read_success_msg'));
    return JSON.parse(account);
  }

  /**
   * Process the data obtained from the database.
   */
  async getAccountData() {
    this.accountData = await this.getPreference();
    return this.accountData;
  }

  writeData(account:Account) {

    this.putPreference(account);
    this.showToastMessage($r('app.string.write_success_msg'));
  }


  showToastMessage(message: Resource) {
    promptAction.showToast({
      message: message,
      duration: CommonConstants.DURATION
    });
  };
}

export default new PreferenceModel();