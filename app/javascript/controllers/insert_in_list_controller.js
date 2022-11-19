import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static targets = ["items", "form", "first", "infos", "formEdit"]
  static values = { position: String }

  connect() {
    console.log(this.element)
    console.log(this.itemsTarget)
    console.log(this.formTarget)
    console.log(this.firstTarget)
  }

  send(event) {
    event.preventDefault()
    const url = this.formTarget.action

    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
      if (data.inserted_item) {
        this.itemsTarget.insertAdjacentHTML(this.positionValue, data.inserted_item)
        // this.formTarget.classList.add("d-none")
        this.firstTarget.classList.add("d-none")
      } else {
      this.formTarget.outerHTML = data.form
      }
    })
  }

  displayForm() {
    this.formEditTarget.classList.remove("d-none")
    this.infosTarget.classList.add("d-none")
  }

  update(event) {
    event.preventDefault()
    const url = this.formEditTarget.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formEditTarget)
    })
    .then(response => response.json())
    .then((data) => {
      if (data.inserted_item) {
        this.itemsTarget.insertAdjacentHTML(this.positionValue, data.inserted_item)
        this.formEditTarget.classList.add("d-none")
        this.formEditTarget.classList.add("d-none")
      }
    })
  }
}
