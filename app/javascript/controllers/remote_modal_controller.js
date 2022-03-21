import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="remote-modal"
export default class extends Controller {
  connect() {
    // console.log('Remote Modal connect: ', this.element)
    this.modal = new Modal(this.element)
    this.modal.show()
  }

  // hideBeforeRender(event) {
  //   console.log('Remote Modal disconnect: ', this.element)
  //   if (this.isOpen()) {
  //     event.preventDefault()
  //     this.element.addEventListener('hidden.bs.modal', event.detail.resume)
  //     this.modal.hide()
  //   }
  // }

  // hideAfterCreate(event) {
  //   console.log('Remote Modal hideAfterCreate: ', this.element)
  //   console.log('event.detail: ', event.detail)
  //   console.log('status (200): ', event.detail['fetchResponse']['response']['status'])
  //   if (event.detail['fetchResponse']['response']['status'] === 200) {
  //     this.modal.hide()
  //   }
  // } 

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
