import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mark-favorite"
export default class extends Controller {
  static targets = ["button"]
  static classes = ["unliked", "liked"]
  connect() {
    const status = this.element.innerHTML
  }

  toggle(event) {
    event.preventDefault()
    this.element.innerHTML.includes("btn-info")
  }
}
