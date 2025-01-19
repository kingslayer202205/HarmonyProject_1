
export default class ButtonItemData {


  resource: Resource;


  clickMethod: () => void;


  constructor(resource: Resource, clickMethod: () => void) {
    this.resource = resource;
    this.clickMethod = clickMethod;
  }
}