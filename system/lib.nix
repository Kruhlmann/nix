{ pkgs, ... }: {
  environment.etc."usr/local/lib/opensc-pkcs11.so".source =
    "${pkgs.opensc}/lib/opensc-pkcs11.so";
}

