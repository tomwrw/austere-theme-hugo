/* Colour scheme: system -> light -> dark -> system. Runs blocking in <head> so a
   stored choice is applied before the first paint. */
(function () {
  var KEY = 'theme';
  var root = document.documentElement;

  function read() {
    try { return localStorage.getItem(KEY); } catch (e) { return null; }
  }

  function write(value) {
    try {
      if (value) { localStorage.setItem(KEY, value); } else { localStorage.removeItem(KEY); }
    } catch (e) { /* blocked storage: the toggle still works for this page */ }
  }

  function syncMeta() {
    var meta = document.getElementById('theme-color');
    if (!meta) return;
    var bg = getComputedStyle(root).getPropertyValue('--bg').trim();
    if (bg) meta.setAttribute('content', bg);
  }

  function apply(value) {
    if (value === 'light' || value === 'dark') {
      root.setAttribute('data-theme', value);
    } else {
      root.removeAttribute('data-theme');
    }
    syncMeta();
  }

  apply(read());

  window.austereTheme = function () {
    var current = read();
    var next = current === 'light' ? 'dark' : (current === 'dark' ? null : 'light');
    write(next);
    apply(next);

    var button = document.querySelector('.theme');
    if (button) {
      var label = button.getAttribute('data-label-' + (next || 'system'));
      if (label) {
        button.setAttribute('title', label);
        button.setAttribute('aria-label', label);
      }
    }
  };

  /* Following the system, a change to the OS setting repaints through CSS.
     Only the theme-color meta needs telling. */
  var query = window.matchMedia('(prefers-color-scheme: dark)');
  if (query.addEventListener) {
    query.addEventListener('change', syncMeta);
  } else if (query.addListener) {
    query.addListener(syncMeta);
  }
})();
