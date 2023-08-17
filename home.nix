{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.zig
    pkgs.cargo
    pkgs.nodejs_20
    pkgs.cmake
    pkgs.gnumake
    pkgs.gcc
    pkgs.ripgrep
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    # ".config/nvim" = {
    #   source = builtins.fetchGit {
    #     url = "https://github.com/redredacted/nvimrc.git";
    #     ref = "main";
    #     rev = "8ec45a07d907e10785bae4cc551bc0f6a58b49d1";
    #   };
    #   recursive = true;
    # };
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/root/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  xdg.configFile.nvim = {
    source = builtins.fetchGit {
      url = "https://github.com/redredacted/nvimrc.git";
      ref = "main";
      rev = "e7c84d8e4df0a03b6badb5e8abe8b033c1cbd844";
    };
    recursive = true;
  };

  programs.go.enable = true;
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
  programs.zsh = {
    enable = true;
    prezto.enable = true;
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.zellij = {
    enable = true;
    # enableZshIntegration = true;
  };
  prorams.git = {
    enable = true;
    userName = "redredacted";
  };
  programs.lsd = {
    enable = true;
    enableAliases = true;
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
