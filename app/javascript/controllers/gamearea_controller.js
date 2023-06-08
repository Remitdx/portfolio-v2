import { preventOverflow } from "@popperjs/core";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["dice", "form", "list"]

  lockdice(event) {
    //this.diceTargets.forEach(elem => console.log(elem.id))

    fetch(event.target.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
  };
}
