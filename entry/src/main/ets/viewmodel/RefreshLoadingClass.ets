
@Observed
export default class RefreshLoadingClass {

  /**
   * Custom refresh load layout imageSrc.
   */
  imageSrc: Resource;

  /**
   * Custom refresh load layout textValue.
   */
  textValue: Resource;

  /**
   * Custom refresh load layout heightValue.
   */
  heightValue: number;

  constructor(imageSrc: Resource, textValue: Resource, heightValue: number) {
    this.imageSrc = imageSrc;
    this.textValue = textValue;
    this.heightValue = heightValue;
  }
}
