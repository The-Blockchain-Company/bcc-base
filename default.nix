{ system ? builtins.currentSystem
, crossSystem ? null
# allows to customize haskellNix (ghc and profiling, see ./nix/haskell.nix)
, config ? {}
# allows to override dependencies of the project without modifications,
# eg. to test build against local checkout of tbco-nix:
# nix build -f default.nix bcc-base --arg sourcesOverride '{
#   tbco-nix = ../tbco-nix;
# }'
, sourcesOverride ? {}
# pinned version of nixpkgs augmented with overlays (tbco-nix and our packages).
, pkgs ? import ./nix { inherit system crossSystem config sourcesOverride; }
, gitrev ? pkgs.tbcoNix.commitIdFromGitRepoOrZero ./.git
}:
with pkgs; with commonLib;
let

  haskellPackages = recRecurseIntoAttrs
    # we are only interested in listing the project packages:
    (selectProjectPackages bccBaseHaskellPackages);

  self = {
    inherit haskellPackages;

    # `tests` are the test suites which have been built.
    tests = collectComponents' "tests" haskellPackages;
    # `benchmarks` (only built, not run).
    benchmarks = collectComponents' "benchmarks" haskellPackages;

    checks = recurseIntoAttrs {
      # `checks.tests` collect results of executing the tests:
      tests = collectChecks haskellPackages;
    };

    shell = import ./shell.nix {
      inherit pkgs;
      withHoogle = true;
    };
};
in self
