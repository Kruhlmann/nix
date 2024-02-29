{ ... }: {
  programs.zsh = {
    enable = true;
    histSize = 10000;
    autosuggestions.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "lambda";
    };
  };
}
