

import { fileIo } from '@kit.CoreFileKit';
import { request } from '@kit.BasicServicesKit';
import { picker } from '@kit.CoreFileKit';
import Constants, { ContentType, RequestMethod, UploadingState } from '../constant/Constants';
import ResponseResult from '../../viewmodel/ResponseResult';
import Logger from './Logger';
import { showToast } from './Toast';


export async function fileSelect(): Promise<string> {
  let photoSelectOptions = new picker.PhotoSelectOptions();
  photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
  photoSelectOptions.maxSelectNumber = 1;
  let photoPicker = new picker.PhotoViewPicker();
  try {
    let photoSelectResult = await photoPicker.select(photoSelectOptions);
    if (photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0) {
      let imgUri = photoSelectResult.photoUris[0];
      if (imgUri.indexOf('media/Photo')<0) {
        showToast($r('app.string.prompt_select_img'));
        return '';
      }
      return photoSelectResult.photoUris[0];
    } else {
      return '';
    }
  } catch (err) {
    Logger.error('SelectedImage failed', JSON.stringify(err));
    return '';
  }
}

//Upload file.

export function fileUpload(context: Context, fileUri: string): Promise<ResponseResult> {
  // Obtaining the Application File Path.
  let cacheDir = context.cacheDir;
  let imgName = fileUri.split('/').pop() + '.jpg';
  let dstPath = cacheDir + '/' + imgName;
  let url: string = Constants.SERVER + Constants.UPLOAD_FILE;
  let uploadRequestOptions: request.UploadConfig = {
    url: url,
    header: {
      'Content-Type': ContentType.FORM
    },
    method: RequestMethod.POST,
    files: [{
      filename: imgName,
      name: 'file',
      uri: 'internal://cache/' + imgName,
      type: 'jpg'
    }],
    data: []
  };

  let serverData = new ResponseResult();
  return new Promise((resolve: Function, reject: Function) => {
    try {
      // Copy the URI to the cacheDir directory and upload the file.
      let srcFile = fileIo.openSync(fileUri);
      let dstFile = fileIo.openSync(dstPath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
      fileIo.copyFileSync(srcFile.fd, dstFile.fd);
      fileIo.closeSync(srcFile);
      fileIo.closeSync(dstFile);

      // Upload the file.
      request.uploadFile(context, uploadRequestOptions).then((data: request.UploadTask) => {
        data.on(UploadingState.COMPLETE, (result: Array<request.TaskState>) => {
          Logger.info('uploadFile success', JSON.stringify(result));
          if (result && result.length >= 1) {
            serverData.code = Constants.SERVER_CODE_SUCCESS;
            serverData.msg = result[0].message;
            serverData.data = Constants.IMAGE_PREFIX + result[0].path.split('/').pop();
            resolve(serverData);
          }
        });
        data.on(UploadingState.FAIL, (result: Array<request.TaskState>) => {
          Logger.info('uploadFile failed', JSON.stringify(result));
          if (result && result.length >= 1) {
            serverData.msg = $r('app.string.upload_error_message');
            reject(serverData);
          }
        })
      }).catch((err: Error) => {
        Logger.error('uploadFile failed', JSON.stringify(err));
        reject(serverData);
      });
    } catch (err) {
      Logger.error('uploadFile failed', JSON.stringify(err));
      reject(serverData);
    }
  })
}