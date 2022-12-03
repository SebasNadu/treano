import { Controller } from "@hotwired/stimulus"
import swal from 'sweetalert'

// Connects to data-controller="sweet-alert"
export default class extends Controller {
  connect() {
  }
}

// const initSweetalert = (selector, options = {}) => {
//   const swalButton = document.querySelector(selector);
//   if (swalButton) { // protect other pages
//     swalButton.addEventListener('click', () => {
//       swal(options);
//     });
//   }
// };

