{ ... }: {
  twdiscord = {
    name = "twdiscord";
    builtin = true;
    dlls = [ "twdiscord.dll" ];
  };
  superwow = {
    name = "SuperWoW";
    url =
      "https://github.com/balakethelock/SuperWoW/releases/download/Release/SuperWoW.release.1.5.1.zip";
    sha256 = "sha256-MzhyE8RVmtEHCseWlbc7ll3OznDDXjLKaYDi18o4T8E=";
    dlls = [ "SuperWoWhook.dll" ];
  };
}
