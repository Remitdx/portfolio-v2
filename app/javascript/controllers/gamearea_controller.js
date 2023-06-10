import { preventOverflow } from "@popperjs/core";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["dice", "form", "list"]

  lockdice(event) {

    fetch(event.target.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    }).then(response => response.json())
      .then((data) => {
        console.log(data)
      })

    event.target.classList.toggle("locked");
  };

  throwdices() {
    const url = window.location.href

    console.log(url);
  }
}
