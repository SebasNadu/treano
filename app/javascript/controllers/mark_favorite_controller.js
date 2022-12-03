import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mark-favorite"
export default class extends Controller {
  static targets = ["button"]
  connect() {
    // console.log(this.element.innerHTML)
  }

  toggle(event) {
    console.log("I have been toggled")
    console.log(event.target)
    if (this.element.innerHTML.includes("btn-danger")) {
      console.log("I am working")
      this.element.classList.remove("btn-danger");
      this.element.classList.add("btn-info");
    } else if (this.element.innerHTML.includes("btn-info")) {
      this.element.classList.remove("btn-info");
      this.element.classList.add("btn-danger");
    };
  };
}
