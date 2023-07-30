import { preventOverflow } from "@popperjs/core";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["btnHeal", "form", "turn", "btn", "insertHealInfo"]

  lockdice(event) {

    fetch(event.target.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })

    event.target.classList.toggle("locked");

    let s = 0;
    this.formTargets.forEach((form) => {
      if (form.className.includes('locked')) { s++; };
    });
    if (s >= 5) { this.btnTarget.value = 'Valider les dés'; }
    else if (this.turnTarget.innerText.match('5')) { console.log('yay !!');}
    else { this.btnTarget.value = 'Jeter les dés'; }
  };

  throwdices() {
    // vérifier qu'un nouveau dé est locké !
    // s'assurer qu'un dès locké au tour précédent n'est pas délocké.
    // this.btnTarget.value = 'Valider les dés'
  }

  attack(event) {
    event.preventDefault();
    console.log("attack!");
    this.btnTarget.classList.remove('disabled');
  }

  heal(event) {
    event.preventDefault();
    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    }).then(response => response.json())
      .then((data) => {
        console.log(data);
        this.btnHealTarget.classList.add('disabled');
        this.insertHealInfoTarget.classList.add('dice');
        this.insertHealInfoTarget.insertAdjacentHTML("beforeend", data.value);
        this.insertHealInfoTarget.insertAdjacentHTML("afterend", `Yaaay ! Tu te soignes de ${data.value} ${data.value === 1 ? "point" : "points"} !`);
        this.btnTarget.classList.remove('disabled');
      })

  }
}
