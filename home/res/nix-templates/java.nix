{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = [
    pkgs.openjdk
    pkgs.maven
    pkgs.ant
    pkgs.jdt-language-server
    pkgs.mkcert
    pkgs.nss
  ];

  shellHook = ''
    export JAVA_HOME=$(dirname $(dirname $(which javac)))
    export ANT_OPTS="-Djdk=$JAVA_HOME"
  '';
}
