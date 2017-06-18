with (import <nixpkgs> {});

stdenv.mkDerivation rec {
  name = "xcb-demo";

  # Build-time and development tools.
  nativeBuildInputs = [
    cargo
    clang # Use gcc instead if you prefer.
    rustc
    rustfmt
    python3
  ];

  # Libraries required at runtime.
  buildInputs = [
    xorg.libxcb
  ];

  lib_path = lib.makeLibraryPath buildInputs;

  # Edit the compiled program so that it knows where to look for the libraries
  # it needs.
  postFixup = ''
    for f in target/*/"$name"; do
      patchelf --set-rpath "$lib_path" "$f"
    done
  '';
}
