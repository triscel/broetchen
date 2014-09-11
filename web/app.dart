import 'dart:html';
import 'dart:async';




var imageCount = 7;

DivElement slideshowContainer;
ImageElement imgElement;

void main() {
  slideshowContainer = querySelector('#slideshow');
  imgElement = slideshowContainer.querySelector('img.clip');

//  imgElement.onClick.listen((_) => slideshowContainer.querySelector('#logo').classes.toggle('visible'));

  preloadImage(0).then((_) => queueNextImage(1));

}


setImage({ int index: 0 }) {
  imgElement.src = imageSrc(index);

  queueNextImage(index + 1);

}

String imageSrc(int index) => "images/brot${index + 1}.jpg";


Future preloadImage(int index) {
  var img = new ImageElement(src: imageSrc(index));
  return img.onLoad.first;
}


/**
 * Preloads the image, and calls [setImage] after 1 second.
 * If the image isn't loaded after 1 second, it waits for the
 * image to load before calling [setImage].
 */
queueNextImage(int index) {
  if (index >= imageCount) {
    slideshowContainer.querySelector('#logo').classes.add('visible');
    return;
  }

  Future loaded = preloadImage(index);

  new Timer(new Duration(seconds: 1), () {
    loaded.then((_) => setImage(index: index));
  });



}