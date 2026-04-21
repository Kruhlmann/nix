{ lib, ... }: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    syntaxHighlighting.enable = true;

    history.save = 10000;
    history.path = "/home/ges/.zsh_history";
    history.share = true;

    initContent = lib.mkAfter ''
      git_branch() {
        test -d .git || return
        git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'
        printf ' '
      }

      bindkey '^[[1;5C' forward-word 
      bindkey '^[[1;5D' backward-word 

      source ~/.config/zsh/opam.zsh
      setopt PROMPT_SUBST
      PS1='%n@%m:%1~ $(git_branch)%# '
    '';

    shellAliases = {
      "e" = "nvim";
      "gg" = "lazygit";
      "cat" = "bat --paging=never";
      "ls" = "eza";
    };
  };
}
