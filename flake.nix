{
  description = "austere - a minimal Hugo theme with a focus on writing";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            pkgs.hugo
            pkgs.just
            pkgs.git
            pkgs.lychee
          ];

          shellHook = ''
            echo "austere theme dev shell - hugo $(hugo version | cut -d' ' -f2)"
            echo "  just serve    live-reload the example site on http://localhost:1313"
            echo "  just check    strict build (warnings are errors)"
            echo "  just --list   everything else"
          '';
        };
      });

      # `nix build` renders exampleSite with the theme staged into themes/austere,
      # which is exactly how a consumer installs it via git submodule.
      packages = forAllSystems (pkgs: rec {
        default = demo;

        demo = pkgs.stdenvNoCC.mkDerivation {
          pname = "austere-demo";
          version = "0.1.0";

          src = builtins.path {
            path = ./.;
            name = "austere-theme-hugo";
            filter = path: type:
              let base = baseNameOf path; in
              base != ".git" && base != "public" && base != "result" && base != ".direnv";
          };

          nativeBuildInputs = [ pkgs.hugo ];

          buildPhase = ''
            runHook preBuild

            export HUGO_CACHEDIR="$TMPDIR/hugo-cache"
            export XDG_CACHE_HOME="$TMPDIR/cache"

            mkdir -p site/themes/austere
            cp -r exampleSite/. site/
            for entry in layouts assets i18n static archetypes theme.toml; do
              if [ -e "$entry" ]; then
                cp -r "$entry" site/themes/austere/
              fi
            done

            hugo \
              --source site \
              --theme austere \
              --minify \
              --panicOnWarning \
              --destination "$TMPDIR/public"

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall
            cp -r "$TMPDIR/public" $out
            runHook postInstall
          '';
        };
      });

      # `nix flake check` == "the theme still builds".
      checks = forAllSystems (pkgs: {
        demo = self.packages.${pkgs.stdenv.hostPlatform.system}.demo;
      });

      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);
    };
}
