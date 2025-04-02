import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Task controller connected")
  }

  static targets = ["title", "description", "status", "titleError", "descriptionError", "statusError", "form", "updatedTitle", "updatedDescription", "updatedStatus", "updatedTitleError", "updatedDescriptionError", "updatedStatusError"]

  show(event) {
    event.preventDefault()
    if (this.formTarget.classList.contains("hidden")) {
      this.formTarget.classList.remove("hidden")
    }else{
      this.formTarget.classList.add("hidden")
    }
  }

  create(event){
    let isValid = true;

    if(this.titleTarget.value.trim() === ""){
      isValid = false;
      this.titleErrorTarget.classList.remove("hidden")
    } else {
      this.titleErrorTarget.classList.add("hidden")
    }

    if(this.descriptionTarget.value.trim() === ""){
      isValid = false;
      this.descriptionErrorTarget.classList.remove("hidden")
    } else {
      this.descriptionErrorTarget.classList.add("hidden")
    }

    if(this.statusTarget.value.trim() === ""){
      isValid = false;
      this.statusErrorTarget.classList.remove("hidden")
    } else {
      this.statusErrorTarget.classList.add("hidden")
    }

    if(!isValid){
      event.preventDefault()
    }
  }

  update(event){
    let isValid = true;

    if(this.updatedTitleTarget.value.trim() === ""){
      isValid = false;
      this.updatedTitleErrorTarget.classList.remove("hidden")
    } else {
      this.updatedTitleErrorTarget.classList.add("hidden")
    }

    if(this.updatedDescriptionTarget.value.trim() === ""){
      isValid = false;
      this.updatedDescriptionErrorTarget.classList.remove("hidden")
    } else {
      this.updatedDescriptionErrorTarget.classList.add("hidden")
    }

    if(this.updatedStatusTarget.value.trim() === ""){
      isValid = false;
      this.updatedStatusErrorTarget.classList.remove("hidden")
    } else {
      this.updatedStatusErrorTarget.classList.add("hidden")
    }

    if(!isValid){
      event.preventDefault()
    }
  }

}
