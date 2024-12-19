import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["heart"]

  connect() {
    this.isFavorited = this.element.dataset.favorited === "true"
  }

  toggle(event) {
    event.preventDefault()
    const recipeId = this.element.dataset.recipeId
    console.log(this.element.dataset.userRecipeId);

    const url = this.isFavorited ?
      `/user_recipes/${this.element.dataset.userRecipeId}` :
      '/user_recipes'

    fetch(url, {
      method: this.isFavorited ? 'DELETE' : 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content,
        'Content-Type': 'application/json'
      },
      body: this.isFavorited ? null : JSON.stringify({ recipe_id: recipeId })
    })
    .then(response => {
      if (response.ok) {
        this.isFavorited = !this.isFavorited
        this.updateHeartIcon()
      }
    })
  }

  updateHeartIcon() {
    const heartIcon = this.heartTarget
    heartIcon.src = this.isFavorited ?
      'https://res.cloudinary.com/damvtycj5/image/upload/v1734622735/y5mkv581e9py5qahrz3b.png' :
      'https://res.cloudinary.com/damvtycj5/image/upload/v1734622598/q1qpxkedydun2rdvbuih.png'
  }
}
