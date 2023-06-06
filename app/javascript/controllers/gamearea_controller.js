import { preventOverflow } from "@popperjs/core";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["dice"]

  connect() {
    this.diceTargets.forEach(dice => console.log(dice.innerHTML));
  };

  lockdice(event) {
    console.log(event.target.innerHTML);

    fetch(event.target.action, {
      method: "PATCH",
      headers: { "Accept": "application/json" },
      body: new FormData(event.target)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
  };
}
