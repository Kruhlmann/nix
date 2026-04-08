{ ... }: {
  twdiscord = {
    name = "twdiscord";
    dlls = [ "twdiscord.dll" ];
    kind = "builtin";
  };
  superwow = {
    name = "SuperWoW";
    url =
      "https://github.com/balakethelock/SuperWoW/releases/download/Release/SuperWoW.release.1.5.1.zip";
    sha256 = "sha256-MzhyE8RVmtEHCseWlbc7ll3OznDDXjLKaYDi18o4T8E=";
    dlls = [ "SuperWoWhook.dll" ];
    kind = "zip";
  };
  nampower = {
    name = "nampower";
    url =
      "https://gitea.com/avitasia/nampower/releases/download/v4.2.0/nampower.dll";
    sha256 = "sha256-P0TU0X+DQkGftArcPIR5i7+BxcCQkotXYSO13mMV1CU=";
    dlls = [ "nampower.dll" ];
    kind = "file";
  };
}
