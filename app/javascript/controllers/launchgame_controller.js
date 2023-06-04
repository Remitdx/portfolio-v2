import { preventOverflow } from "@popperjs/core";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["submit", "list"]

  connect() {
    if (this.listTarget.children.length > 1 ) {
      this.submitTarget.disabled = false;
      this.submitTarget.classList.remove("btn-secondary");
      this.submitTarget.classList.add("btn-primary");
      }
    }
}
