import { Controller } from "@hotwired/stimulus"

const spinner = `
  <div class="col-span-12 container mx-auto h-24 mb-8" id="spinner">
    <div class="loader">Loading...</div>
  </div>`;
// Connects to data-controller="infinite-scroll"
export default class extends Controller {
  static targets = ["area", "pagination"]

  connect() {
    console.log("Hi")
    this.createObserver()
  }

  createObserver() {
    const observer = new IntersectionObserver(
      entries => this.handleIntersect(entries),
      {
        // https://github.com/w3c/IntersectionObserver/issues/124#issuecomment-476026505
        threshold: [0, 1.0],
      }
    )
    observer.observe(this.areaTarget)
  }

  handleIntersect(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        this.loadMore()
      }
    })
  }

  loadMore() {
    const next = this.paginationTarget.querySelector("[rel=next]")
    if (!next) {
      return
    }
    const href = next.href
    fetch(href, {
      headers: {
        Accept: "text/vnd.turbo-stream.html",
      },
    })
      .then(r => r.text())
      .then(html => Turbo.renderStreamMessage(html))
      .then(_ => history.replaceState(history.state, "", href))
  }
}
