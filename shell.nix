{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-24.05.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.rustup
    pkgs.protobuf
    pkgs.opkg-utils
    pkgs.jq
    pkgs.cargo-cross
    pkgs.cargo-deb
    pkgs.libiconv
    pkgs.zeromq
    pkgs.pkg-config
  ];

  shellHook = ''
    export DOCKER_BUILDKIT=1
    export NIX_STORE=/nix/store
    export LIBZMQ_NO_VENDOR=1
    export PKG_CONFIG_ALLOW_SYSTEM_LIBS=1
    export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
    export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:${pkgs.zeromq}/lib/pkgconfig
  '';
}

