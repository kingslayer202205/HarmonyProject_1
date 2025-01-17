
export default class ButtonItemData {

  /**
   * Button item resource.
   */
  resource: Resource;

  /**
   * Button item clickMethod.
   */
  clickMethod: () => void;

  /**
   * The constructor of ButtonItemData.
   *
   * @param resource Button item resource.
   * @param clickMethod Button item clickMethod.
   */
  constructor(resource: Resource, clickMethod: () => void) {
    this.resource = resource;
    this.clickMethod = clickMethod;
  }
}