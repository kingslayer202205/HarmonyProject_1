
@Observed
export default class RefreshLoadingClass {


  imageSrc: Resource;


  textValue: Resource;


  heightValue: number;

  constructor(imageSrc: Resource, textValue: Resource, heightValue: number) {
    this.imageSrc = imageSrc;
    this.textValue = textValue;
    this.heightValue = heightValue;
  }
}
