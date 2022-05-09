# https://input-output-hk.github.io/haskell.nix/tutorials/getting-started/
let
  sources = import ./nix/sources.nix {};
  haskellNix = import sources.haskellNix {};
  pkgs = import
    haskellNix.sources.nixpkgs-2111
    haskellNix.nixpkgsArgs;

in
  pkgs.haskell-nix.project {
    projectFileName = "cabal.project";
    modules = [
      { doCheck = true;
        doCoverage = true;
        doHaddock = true;
        reinstallableLibGhc = true;
        doHoogle = false;
        enableLibraryProfiling = false;
        packages.mtl-compat.doCoverage = false;
      }
    ];

    src = pkgs.haskell-nix.haskellLib.cleanGit {
      name = "pandoc";
      src = ./.;
    };
    compiler-nix-name = "ghc8107";
  }
