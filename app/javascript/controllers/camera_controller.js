import { Controller } from "@hotwired/stimulus"
import { BarcodeDetectorPolyfill } from "https://cdn.jsdelivr.net/npm/@undecaf/barcode-detector-polyfill@latest/dist/main.js";

export default class extends Controller {

  connect() {
    const el = {}

    document
      .querySelectorAll('[id]')
      .forEach(element => el[element.id] = element)

    const
      canvas = el.canvas,
      ctx = canvas.getContext('2d');

    let
      supportedFormats,
      detector,
      requestId = null;

    async function createDetector() {
      supportedFormats = await BarcodeDetectorPolyfill.getSupportedFormats()
      // el.formats.innerHTML = supportedFormats.join(', ')
      detector = new BarcodeDetectorPolyfill({ formats: ['codabar', 'code_39', 'code_93', 'code_128', 'databar', 'databar_exp', 'ean_2', 'ean_5', 'ean_8', 'ean_13', 'ean_13+2', 'ean_13+5', 'isbn_10', 'isbn_13', 'isbn_13+2', 'isbn_13+5', 'itf', 'qr_code', 'sq_code', 'upc_a', 'upc_e'], zbar: { encoding: 'UTF-8' } })
    }

    function detect(source) {
      return detector
        .detect(source)
        .then(symbols => {
          canvas.width = source.naturalWidth || source.videoWidth || source.width
          canvas.height = source.naturalHeight || source.videoHeight || source.height
          ctx.clearRect(0, 0, canvas.width, canvas.height)
          symbols.forEach(symbol => {
            const lastCornerPoint = symbol.cornerPoints[symbol.cornerPoints.length - 1]
            ctx.moveTo(lastCornerPoint.x, lastCornerPoint.y)
            symbol.cornerPoints.forEach(point => ctx.lineTo(point.x, point.y))

            ctx.lineWidth = 3
            ctx.strokeStyle = '#00e000ff'
            ctx.stroke()
          })
          symbols.forEach(symbol => {
            delete symbol.boundingBox
            delete symbol.cornerPoints
            const barcode = symbol.rawValue
            if (barcode.length > 0) {
              handleBarcode(barcode);
            }
          })
        })
    }

    function detectVideo(repeat) {
      if (!repeat) {
        ctx.clearRect(0, 0, canvas.width, canvas.height)
      }

      if (typeof repeat === 'undefined') {
        repeat = true
      }

      if (repeat) {
        detect(el.video)
          .then(() => requestId = requestAnimationFrame(() => detectVideo(true)))

      } else {
        cancelAnimationFrame(requestId)
        requestId = null
      }
    }

    createDetector()

    el.videoBtn.addEventListener('click', event => {

      if (!requestId) {
        navigator.mediaDevices.getUserMedia({ audio: false, video: { facingMode: 'environment' } })
          .then(stream => {
            // el.imgUrl.className = el.imgBtn.className = ''
            el.videoBtn.className = 'button-primary'

            el.video.srcObject = stream
            detectVideo()
          })
          .catch(error => {
            el.result.innerText = JSON.stringify(error)
          })

      } else {

        detectVideo(false)
      }
    })
    function handleBarcode(value) {
      if (value && value.length > 0) {
        // Redirect to new product form with barcode as query parameter
        window.location.href = `/products/new?barcode=${value}`;
      }
    }
  }
}
