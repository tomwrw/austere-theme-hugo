root       := justfile_directory()
themes_dir := parent_directory(justfile_directory())
theme_name := file_name(justfile_directory())

# The theme is served from its own checkout: --themesDir is the parent directory
# and --theme is this directory's name, so nothing breaks if the clone is renamed.
hugo_site := '--source "' + root + '/exampleSite" --themesDir "' + themes_dir + '" --theme "' + theme_name + '"'

# Show available recipes
default:
    @just --list

# Live-reload the example site on http://localhost:1313
serve *ARGS:
    hugo server {{ hugo_site }} \
        --buildDrafts --buildFuture \
        --navigateToChanged --disableFastRender \
        --printPathWarnings {{ ARGS }}

# Build the example site into ./public
build *ARGS:
    hugo {{ hugo_site }} --minify --destination "{{ root }}/public" {{ ARGS }}

# Strict build: any Hugo warning is a failure
check:
    hugo {{ hugo_site }} --minify --panicOnWarning --printPathWarnings \
        --destination "{{ root }}/public"

# Check every internal link in the built site
links: build
    lychee --no-progress --offline --root-dir "{{ root }}/public" "{{ root }}/public"

# Create a new example post as a page bundle
new TITLE:
    hugo new {{ hugo_site }} "posts/{{ TITLE }}/index.md"

# Serve the reference Zola theme on :1111 for side-by-side comparison
zola-compare:
    #!/usr/bin/env bash
    set -euo pipefail
    dir="${TMPDIR:-/tmp}/austere-zola-reference"
    if [ ! -d "$dir" ]; then
        git clone --depth 1 https://github.com/tomwrw/austere-theme-zola "$dir"
    fi
    echo "Zola reference on http://localhost:1111 (Hugo: just serve on :1313)"
    nix run nixpkgs#zola -- --root "$dir" serve --port 1111

# Remove build output
clean:
    rm -rf "{{ root }}/public" "{{ root }}/exampleSite/public" \
           "{{ root }}/exampleSite/resources" "{{ root }}/.hugo_build.lock"

# Print Chroma palettes to map onto the --c-* tokens in assets/css/main.css
chroma STYLE_LIGHT="github" STYLE_DARK="github-dark":
    hugo gen chromastyles --style={{ STYLE_LIGHT }} > /tmp/chroma-light.css
    hugo gen chromastyles --style={{ STYLE_DARK }}  > /tmp/chroma-dark.css
    @echo "Written /tmp/chroma-light.css and /tmp/chroma-dark.css"
