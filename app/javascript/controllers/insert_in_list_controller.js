import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static targets = ["items", "form", "first", "infos", "formEdit", "review"]
  static values = { position: String }

  connect() {
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
        this.formTarget.classList.add("d-none")
        this.firstTarget.classList.add("d-none")
      } else {
      this.formTarget.outerHTML = data.form
      }
    })
  }

  update(event) {
    event.preventDefault()
    const url = this.formEditTarget.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/html" },
      body: new FormEditData(this.formEditTarget)
    })
    .then(response => response.text())
    .then((data) => {
      console.log(data)
      // this.reviewTarget.outerHTML = data
    })
  }
}
