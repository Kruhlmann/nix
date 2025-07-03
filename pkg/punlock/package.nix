{ lib, fetchFromGitHub, rustPlatform, }:
rustPlatform.buildRustPackage rec {
  pname = "punlock";
  version = "d11941f81f2488f918ec24d24d87341797fca6eb";
  src = fetchFromGitHub {
    owner = "Kruhlmann";
    repo = pname;
    rev = version;
    hash = "sha256-AswCz++DwqiKwFHAb6qnJLwymsW3/vsAVb3eohlyNrE=";
  };
  cargoHash = "sha256-q8fifgd7EiG+lHIJkQzzCMfeg15wMlJ8F/ugAQerW4c=";
  postUnpack = ''
    sed -i "s/edition = .2024./edition=\"2018\"/" source/Cargo.toml
  '';
  doCheck = false;
  meta = with lib; {
    description = "PasswordUNLOCKer";
    homepage = "https://github.com/Kruhlmann/punlock";
    changelog = "https://github.com/Kruhlmann/punlock/releases/tag/${version}";
    license = with licenses; [ mit ];
    mainProgram = "punlock";
  };
}
