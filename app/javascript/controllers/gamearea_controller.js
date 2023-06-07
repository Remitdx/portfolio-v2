import { preventOverflow } from "@popperjs/core";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["dice", "list"]

  lockdice() {
    this.diceTargets.forEach(elem => console.log(elem.id))


  };
}
