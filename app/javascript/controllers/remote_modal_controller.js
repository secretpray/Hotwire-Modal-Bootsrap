import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="remote-modal"
export default class extends Controller {
  connect() {
    this.modal = new Modal(this.element)
    this.modal.show()
  }

  removeModal() {
    if (this.isOpen()) {
      this.element.parentElement.src = ''
      this.modal.hide()
    }
  }

  isOpen() {
    return this.element.classList.contains("show")
  }
}
