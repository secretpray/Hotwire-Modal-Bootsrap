import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autohide"
export default class extends Controller {
  static targets = [ 'close' ]
  connect() {
    setTimeout(() => this.dismiss(), 5000)
  }

  dismiss() {
    this.closeTarget.click() 
    // this.element.remove()
  }
}
