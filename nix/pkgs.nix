# our packages overlay
pkgs: _: with pkgs; {
  bccBaseHaskellPackages = import ./haskell.nix {
    inherit config
      lib
      stdenv
      haskell-nix
      buildPackages
      ;
  };

}
