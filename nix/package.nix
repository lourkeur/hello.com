{ stdenv, cosmoc }:

stdenv.mkDerivation {
  name = "hello.com";
  src = builtins.path { path = ../.; name = "hello.com"; };

  buildInputs = [ cosmoc ];

  buildPhase = ''
    cosmoc -o hello.com hello.c
  '';

  installPhase = ''
    mkdir -p $out/bin
    install hello.com $out/bin
  '';
}
