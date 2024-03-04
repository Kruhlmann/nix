{ ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      source /etc/zshrc

      ENABLE_CORRECTION="false"
      COMPLETION_WAITING_DOTS="false"
      HISTFILE=~/.zsh_history
      HISTSIZE=10000
      SAVEHIST=10000
      setopt appendhistory
      unsetopt correct_all
      unsetopt correct

      source ~/.config/zsh/path.sh
      source ~/.config/zsh/plugins.sh
      source ~/.config/zsh/aliases.sh

      export PNPM_HOME="/home/ges/.local/share/pnpm"
      export PATH="$PNPM_HOME:$PATH"
      export PATH="$HOME/.local/bin:$PATH"
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

      [[ ! -r /home/ges/.opam/opam-init/init.zsh ]] || source /home/ges/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
      eval "$(direnv hook zsh)"
    '';
    oh-my-zsh = {
      enable = true;
      theme = "lambda";
      plugins = [ "git" "thefuck" ];
    };
  };
}
