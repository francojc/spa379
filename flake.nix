{
  description = "Entorno para cursos Quarto en español";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachSystem ["aarch64-darwin" "aarch64-linux" "x86_64-linux"] (system: let
      pkgs = import nixpkgs {inherit system;};

      rPackages = with pkgs.rPackages; [
        tidyverse
        knitr
        rmarkdown
        googlesheets4
        gt
        webexercises
        fontawesome
        glue
        languageserver
        reticulate
      ];

      # Both commands must see the same project R libraries.
      r = pkgs.rWrapper.override {packages = rPackages;};
      radian = pkgs.radianWrapper.override {packages = rPackages;};

      # Add standard Nixpkgs tools here, independently of language libraries.
      shellPackages = with pkgs; [
        typst
        tinymist
        git
      ];
    in {
      devShells.default = pkgs.mkShell {
        packages = [r radian] ++ shellPackages;
      };
    });
}
