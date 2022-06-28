/**
 * Process deferred images.
 *
 * Deferred images are not loaded immediately so that we have an opportunity
 * to attach an error handler to them, in order to hide the images that fail to
 * load. This is especially useful when images are scraped from the content
 * and there's no way to know if they are valid or not.
 *
 * This works by having the image SRC pointing to a 1x1 transparent GIF,
 * registering an error handler for the images, and then replacing
 * the `src` attribute by the value of `data-deferred-src` which contains
 * the real image URL
 *
 * @param imageSelector CSS selector to find the images to process
 */

const setupDeferredImages = (imageSelector = 'img.deferred') => {
    const images = document.querySelectorAll(imageSelector)
    for (let i = 0; i < images.length; i++) {
        const image = images[i]
        image.onload = () => image.style.display = 'inline'
        image.onerror = () => {
            image.style.display = 'none'
            image.onerror = null
        }
        image.setAttribute('src', image.getAttribute('data-deferred-src'))
    }
}
