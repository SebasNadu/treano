import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="refresh-search"
export default class extends Controller {
  static targets = ['form', 'clearme', 'titleInput', 'genresInput', 'keywordsInput', 'providersFreeInput', 'providersSubInput', 'providersPurchaseInput', 'providersTveInput', 'result']

  connect() {
    console.log('hello')
  }

  update(event) {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
        this.formTarget.requestSubmit()
      }, 500)
  }

  clean() {
    console.log(this.clearmeTarget)
    this.clearmeTarget.value=''
  }
}
