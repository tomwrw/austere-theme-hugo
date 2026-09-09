/* Click a responsive image to view its largest variant full screen. */
(function () {
  var images = document.querySelectorAll('article img[srcset]');
  if (!images.length) return;

  function largest(img) {
    var candidates = img.srcset.split(',');
    return candidates[candidates.length - 1].trim().split(' ')[0];
  }

  function open(img) {
    var box = document.createElement('div');
    box.className = 'lb';
    box.setAttribute('role', 'dialog');
    box.setAttribute('aria-modal', 'true');

    var full = document.createElement('img');
    full.src = largest(img);
    full.alt = img.alt || '';
    box.appendChild(full);

    function close() {
      box.remove();
      document.body.style.overflow = '';
      document.removeEventListener('keydown', onKey);
    }
    function onKey(event) {
      if (event.key === 'Escape') close();
    }

    box.addEventListener('click', close);
    document.addEventListener('keydown', onKey);
    document.body.style.overflow = 'hidden';
    document.body.appendChild(box);
  }

  images.forEach(function (img) {
    if (img.closest('a')) return;
    img.style.cursor = 'pointer';
    img.addEventListener('click', function () { open(img); });
  });
})();
