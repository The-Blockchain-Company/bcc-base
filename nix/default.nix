{ system ? builtins.currentSystem
, crossSystem ? null
, config ? {}
, sourcesOverride ? {}
}:
let
  sources = import ./sources.nix { inherit pkgs; }
    // sourcesOverride;
  bcccoinNixMain = import sources.bcccoin-nix {};
  haskellNix = (import sources."haskell.nix" { inherit system sourcesOverride; }).nixpkgsArgs;
  # use our own nixpkgs if it exists in our sources,
  # otherwise use bcccoinNix default nixpkgs.
  nixpkgs = if (sources ? nixpkgs)
    then (builtins.trace "Not using The Blockchain Co (TBCO) default nixpkgs (use 'niv drop nixpkgs' to use default for better sharing)"
      sources.nixpkgs)
    else (builtins.trace "Using The Blockchain Co (TBCO) default nixpkgs"
      bcccoinNixMain.nixpkgs);

  # for inclusion in pkgs:
  overlays =
    # Haskell.nix (https://github.com/The-Blockchain-Company/haskell.nix)
    haskellNix.overlays
    # haskell-nix.haskellLib.extra: some useful extra utility functions for haskell.nix
    ++ bcccoinNixMain.overlays.haskell-nix-extra
    ++ bcccoinNixMain.overlays.crypto
    # bcccoinNix: nix utilities and niv:
    ++ bcccoinNixMain.overlays.bcccoinNix
    # our own overlays:
    ++ [
      (pkgs: _: with pkgs; {
        # commonLib: mix pkgs.lib with bcccoin-nix utils and our own:
        commonLib = lib // bcccoinNix
          // import ./util.nix { inherit haskell-nix; }
          # also expose our sources and overlays
          // { inherit overlays sources; };
      })
      # And, of course, our haskell-nix-ified cabal project:
      (import ./pkgs.nix)
    ];

  pkgs = import nixpkgs {
    inherit system crossSystem overlays;
    config = haskellNix.config // config;
  };

in pkgs
