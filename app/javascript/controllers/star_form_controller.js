import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="star-form"
export default class extends Controller {
  connect() {
  }
  submit() {
    this.element.submit();
  }
}
