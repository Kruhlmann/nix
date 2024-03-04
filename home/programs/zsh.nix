{ ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    history.save = 10000;
    history.path = ~/.zsh_history;
    history.share = true;
    initExtraFirst = ''
      source /etc/zshrc
    '';
    initExtra = ''
      source ~/.config/zsh/opam.zsh
    '';
    oh-my-zsh = {
      enable = true;
      theme = "mortalscumbag";
      plugins = [ "git" "thefuck" ];
    };
  };
}
