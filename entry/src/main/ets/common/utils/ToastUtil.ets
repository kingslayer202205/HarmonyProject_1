
import { promptAction } from '@kit.ArkUI';
import Constants from '../constant/Constants';

export function showToast(msg: string | Resource) {
  promptAction.showToast({
    message: msg,
    duration: Constants.ANIMATION_DURATION
  });
}