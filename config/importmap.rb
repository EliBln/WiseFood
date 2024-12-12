# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "tesseract.js", to: "https://cdn.jsdelivr.net/npm/tesseract.js@5/dist/tesseract.min.js"
pin "#src/worker/node/index.js", to: "#src--worker--node--index.js.js" # @5.1.1
pin "is-electron" # @2.2.2
pin "process" # @2.1.0
pin "regenerator-runtime/runtime", to: "regenerator-runtime--runtime.js" # @0.13.11
pin "@undecaf/barcode-detector-polyfill", to: "@undecaf--barcode-detector-polyfill.js" # @0.9.21
