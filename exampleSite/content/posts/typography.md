+++
title = "Typography"
description = "Headings, links, code blocks, blockquotes and lists, so you can see how the theme sets each of them."
date = 2023-01-16
tags = ["Hugo", "Theme", "Markdown", "Typography"]
categories = ["Reference"]
+++


Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.

## Heading 1

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

### Heading 2

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

#### Heading 3

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

---

This is [an example link](http://example.com/ "Title"). Here is **bold text** and *emphasised text*.

Following is the syntax highlighted code block

```rust
fn main() {
    let x = 5u32;

    let y = {
        let x_squared = x * x;
        let x_cube = x_squared * x;

        // This expression will be assigned to `y`
        x_cube + x_squared + x
    };

    let z = {
        // The semicolon suppresses this expression and `()` is assigned to `z`
        2 * x;
    };

    println!("x is {:?}", x);
    println!("y is {:?}", y);
    println!("z is {:?}", z);
}

```

Inline code looks like `this` and can include things like `fn main()` or `const x = 42`.

Blockquotes:

> 'I want to do with you what spring does with the cherry trees.' — Pablo Neruda

> Lorem ipsum *dolor sit amet*, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.

Unordered list

* Red
* Green
* Blue

Ordered list

1. Red
2. Green
3. Blue

Tables

| Token | Light | Dark | Used for |
|---|---|---|---|
| `--bg` | `#FAF7F2` | `#141413` | Page background |
| `--text` | `#1a1a1a` | `#e8e8e8` | Body copy |
| `--accent` | `#9E4440` | `#E07A5F` | Links, rules, the mark |
| `--code-bg` | `#f0ebe3` | `#1e1e1d` | Code blocks and inline code |

A table wider than the screen scrolls on its own rather than stretching the page.
So does a long unbroken string, such as
https://example.org/an/unreasonably/long/path/that/nothing/would/sensibly/link/to/but/here/we/are
which wraps instead of pushing the layout sideways.
