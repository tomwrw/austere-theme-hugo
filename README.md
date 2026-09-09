<p align="center">
  <img src="images/logo.svg" alt="austere" width="160">
</p>

<h1 align="center">austere</h1>

<p align="center">A minimal Hugo theme for people who mostly write.</p>

---

Serif type, a light and dark palette, and not much else. A page loads no stylesheet, no web font and nothing from a CDN: the CSS is inlined and the icons are inline SVG, so a post is one request.

It's a port of [austere for Zola](https://github.com/tomwrw/austere-theme-zola), which in turn owes its design to [Zap](https://github.com/jimmyff/zola-zap) by [jimmyff](https://github.com/jimmyff). I wrote the original Zola theme, but I am now using Hugo and wanted to bring my theme with me.

Requires Hugo 0.146 or newer. The extended edition is needed only if you keep WebP as the image format; see `params.images` below.

## Install

From the root of your Hugo project, run:

```bash
git submodule add https://github.com/tomwrw/austere-theme-hugo themes/austere
```

Then, in your `hugo.toml`:

```toml
theme = "austere"
```

The theme sets no requirements on your `markup`, `outputs` or `taxonomies` configuration, and every parameter below is optional.

Remember `git clone --recurse-submodules` when you clone your site elsewhere, and `submodules: recursive` on `actions/checkout` in CI.

## Configuration

```toml
[params]
  description = "Notes on things"        # meta description, feed subtitle
  author = "Your Name"
  keywords = "writing, hugo"

  strapline = "and other distractions"   # sits after the site title
  footerText = "© 2026"                  # HTML allowed
  favicon = "/favicon.ico"
  profilePicture = "/images/me.png"      # home page only
  siteIcon = "quill"                     # "quill", a path to your own, or ""
  undatedPosition = "below"              # where undated pages sit in a list

  [params.images]                        # responsive images
    sizes = [512, 1024, 2048]            # srcset widths
    defaultSize = 1024                   # width of the src fallback
    quality = 80
    format = "webp"                      # webp | jpeg | png | original

  [params.umami]                         # optional analytics
    websiteId = ""
    src = "https://cloud.umami.is/script.js"
    domains = ""

# Google Analytics goes through Hugo's own setting:
[services.googleAnalytics]
  ID = "G-XXXXXXXXXX"

[menus]
  [[menus.main]]
    name = "Posts"
    pageRef = "/posts"
    weight = 10
```

Analytics only render in production builds. The navigation is Hugo's normal menu; with no menu configured the theme leaves it out entirely.

`exampleSite/` is a working site you can copy from.

## Writing

Nothing special is needed. Posts go in `content/posts/`, other pages anywhere in `content/`, and any page with a `date` gets a dated header. Sections are not hard-coded, so `content/writing/` behaves the same as `content/posts/`.

Pages are footed with every taxonomy they use, so tags, categories and anything else you declare in `[taxonomies]` all show up without the theme needing to know their names.

A page with no `date` keeps its dateless header and collects in an **Undated** block at the end of list pages, rather than sorting itself to the year one. Set `undatedPosition = "above"` to put that block first.

Keep a post's images beside it in a page bundle and write them the ordinary way:

```
content/posts/a-walk/
├── index.md
└── hill.jpg
```

```markdown
![The hill](hill.jpg)
```

Images are resized to each width in `params.images.sizes` and served as a `srcset`, with the largest opening in a lightbox on click — a mouse affordance only, so nothing is lost without it. SVG, GIF, files in `static/` and images on other domains are left alone.

Set `description` in a page's front matter when you want to control the social preview text. Without one, Hugo falls back to the page summary, which on a long home page is possibly more than you want.

## Colours and type

The palette lives in `assets/css/main.css` as custom properties. To change any of it, add `assets/css/custom.css` to your own site - the theme appends it, so you only need the lines you're overriding:

```css
:root { --accent: #2f6f4f }
:root[data-theme="dark"] { --accent: #7fd1a8 }
```

The tokens are `--bg`, `--text`, `--heading`, `--muted`, `--quote`, `--accent`,
`--accent-hover`, `--code-bg`, `--border`, plus `--c-*` for the syntax highlighting. Run `hugo gen chromastyles --style=<name>` to see the colours from any other Chroma palette.

No fonts are downloaded. `--font-serif` asks for Source Serif, then Charter, Sitka and Georgia, then Noto Serif and the other serifs usually found on Linux.

The named Linux families matter: a desktop is free to alias the generic `serif` to whatever it likes, including a sans face, and several do.

The colour scheme cycles system, light, dark. The choice is kept in `localStorage` and applied before the first paint, so there's no flash. With nothing stored the page follows `prefers-color-scheme` and reacts if the reader changes it.

Body text is justified. If you'd rather it weren't, that's one line in `custom.css`:

```css
p { text-align: left }
```

## Overriding templates

A file at the same path in your site's `layouts/` wins over the theme's, so to change the footer, add your own `layouts/_partials/footer.html`. The templates worth knowing about:

```
layouts/
  baseof.html
  home.html
  page.html
  section.html
  taxonomy.html
  term.html
  404.html
  alias.html
  _partials/
    head.html
    header.html
    footer.html
    image.html
    pagination.html
    entry-list.html
    undated.html
  _markup/
    render-image.html
    render-link.html
    render-codeblock.html
```

The code block hook calls Chroma with `noClasses: false` regardless of your site config, which is what lets the syntax palette follow the colour scheme without you having to configure
anything.

## Development

Requires [Nix](https://nixos.org), or just Hugo if you'd rather.

```bash
nix develop        # or direnv allow
just serve         # example site on :1313
just check         # build with warnings treated as errors
just links         # link check
just --list
```

Without Nix:

```bash
hugo server --source exampleSite --themesDir ../.. --theme austere-theme-hugo
```

## Credits

- [Zap](https://github.com/jimmyff/zola-zap) by [jimmyff](https://github.com/jimmyff), for the original design inspiration.

MIT, see [LICENSE](LICENSE).
