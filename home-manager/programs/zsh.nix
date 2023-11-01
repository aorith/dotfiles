{...}: {
  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;
    enableVteIntegration = true;
    enableCompletion = true;

    syntaxHighlighting = {
      enable = true;
    };

    initExtra = ''eval "$(starship init zsh)"'';
  };
}
