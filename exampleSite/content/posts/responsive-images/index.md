+++
title = "Responsive images"
date = 2023-01-12
tags = ["Hugo", "Theme"]
categories = ["Reference"]
+++

Keep a post and its images together in a page bundle:

```text
content/posts/responsive-images/
├── index.md
└── 1.png
```

Write the image the ordinary way and the theme handles the rest, resizing it to
each width in `params.images.sizes` and serving them as a `srcset`:

```markdown
![Example image](1.png)
```

![Example image](1.png)

Files that can't usefully be resized — SVG, GIF, anything in `static/` or on
another domain — are passed through untouched.
