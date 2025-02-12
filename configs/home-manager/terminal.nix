{config, pkgs, inputs, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = "
      [ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh \n
    ";

    shellAliases = {
      ll = "ls -l";
      system_update = "sudo nixos-rebuild switch --flake /home/timofey/.dotfiles --impure";
      home_update = "home-manager switch --flake /home/timofey/.dotfiles";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "eastwood";
    };
  };
}
