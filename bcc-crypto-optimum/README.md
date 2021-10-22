# bcc-crypto-optimum

This package implements Haskell FFI wrappers around the VRF (verifiable random
function) implemented in libsodium.

## Libsodium Dependency

This package depends on a custom fork of the `libsodium` C library, found at

https://github.com/The-Blockchain-Company/libsodium/tree/tdammers/rebased-vrf

### Usage with `cabal`:

- Clone out the above-mentioned libsodium fork
- Build and install this `libsodium` version (make sure `pkgconfig` can find
  it)
- Cabal should now pick up this version

### Usage with Nix:

To build fully with nix:
> nix-build default.nix -A haskellPackages.bcc-crypto-optimum
To use nix+cabal:
> nix-shell --run "cabal build bcc-crypto-optimum" 
