import { preventOverflow } from "@popperjs/core";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["btn", "list"]

  toggle() {
    this.listTarget.classList.toggle("d-none");
  }
}
