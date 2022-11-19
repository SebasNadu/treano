import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="treano-carousel"
export default class extends Controller {
  static targets = [ 'progressbar', 'slider' ]

  connect() {
    const throttleProgressBar = this.throttle(() => {
      document.querySelectorAll(".progress-bar").forEach(this.calculateProgressBar)
    }, 250)
    window.addEventListener("resize", throttleProgressBar) 
    this.calculateProgressBar(this.progressbarTarget)
  }

  calculateProgressBar(progressBar) {
    progressBar.innerHTML = ""
    const slider = progressBar.closest(".row").querySelector(".slider")
    const itemCount = slider.children.length
    const itemsPerScreen = parseInt(
      getComputedStyle(slider).getPropertyValue("--items-per-screen")
    )
    let sliderIndex = parseInt(
      getComputedStyle(slider).getPropertyValue("--slider-index")
    )
    const progressBarItemCount = Math.ceil(itemCount / itemsPerScreen)

    if (sliderIndex >= progressBarItemCount) {
      slider.style.setProperty("--slider-index", progressBarItemCount - 1)
      sliderIndex = progressBarItemCount - 1
    }

    for (let i = 0; i < progressBarItemCount; i++) {
      const barItem = document.createElement("div")
      barItem.classList.add("progress-item")
      if (i === sliderIndex) {
        barItem.classList.add("active")
      }
      progressBar.append(barItem)
    }
  }

  updateNext() {
    const sliderIndex = parseInt(
      getComputedStyle(this.sliderTarget).getPropertyValue("--slider-index")
    )
    const progressBarItemCount = this.progressbarTarget.children.length

    if (sliderIndex + 1 >= progressBarItemCount) {
      this.sliderTarget.style.setProperty("--slider-index", 0)
      this.progressbarTarget.children[sliderIndex].classList.remove("active")
      this.progressbarTarget.children[0].classList.add("active")
    } else {
      this.sliderTarget.style.setProperty("--slider-index", sliderIndex + 1)
      this.progressbarTarget.children[sliderIndex].classList.remove("active")
      this.progressbarTarget.children[sliderIndex + 1].classList.add("active")
    }
  }

  updatePrev() {
    const sliderIndex = parseInt(
      getComputedStyle(this.sliderTarget).getPropertyValue("--slider-index")
    )
    const progressBarItemCount = this.progressbarTarget.children.length

    if (sliderIndex - 1 < 0) {
      this.sliderTarget.style.setProperty("--slider-index", progressBarItemCount - 1)
      this.progressbarTarget.children[sliderIndex].classList.remove("active")
      this.progressbarTarget.children[progressBarItemCount - 1].classList.add("active")
    } else {
      this.sliderTarget.style.setProperty("--slider-index", sliderIndex - 1)
      this.progressbarTarget.children[sliderIndex].classList.remove("active")
      this.progressbarTarget.children[sliderIndex - 1].classList.add("active")
    }
  }

  throttle(cb, delay = 1000) {
    let shouldWait = false
    let waitingArgs
    const timeoutFunc = () => {
      if (waitingArgs == null) {
        shouldWait = false
      } else {
        cb(...waitingArgs)
        waitingArgs = null
        setTimeout(timeoutFunc, delay)
      }
    }

    return (...args) => {
      if (shouldWait) {
        waitingArgs = args
        return
      }

      cb(...args)
      shouldWait = true
      setTimeout(timeoutFunc, delay)
    }
  }    
}
