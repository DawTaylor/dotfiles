{ config, pkgs, caelestia-shell, sidra, lib, ... }:

let
  onePassPath =
    if pkgs.stdenv.isDarwin then
      "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "${config.home.homeDirectory}/.1password/agent.sock";
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "daw";
  home.homeDirectory = "/home/daw";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  imports = [
	  caelestia-shell.homeManagerModules.default
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
	  pkgs.vim
	  pkgs.wget
	  pkgs.git
	  pkgs.vscode
    pkgs.python3
    pkgs.awscli
    pkgs.bat
    pkgs.esptool
    pkgs.eza
    pkgs.fd
    pkgs.fzf
    pkgs.gh
    pkgs.helm
    pkgs.jq
    pkgs.kubectl
    pkgs.kustomize
    pkgs.podman
    pkgs.podman-compose
    pkgs.podman-tui
    pkgs.stow
    pkgs.tailscale
    pkgs.terraform
    pkgs.tlrc
    pkgs.talosctl
    pkgs.fluxcd
    pkgs.esphome
    
    
	  pkgs._1password-cli
	  pkgs._1password-gui
	  pkgs.claude-code
	  pkgs.kitty
    pkgs.notion
    pkgs.telegram-desktop
    pkgs.wezterm
    pkgs.android-tools

    sidra.packages.${pkgs.system}.default
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
    "1password/custom_allowed_browsers" = {
      text = ''
	    firefox
      '';
	    executable = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/daw/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # zsh dotfiles (.zshrc, .zsh_aliases, .zsh_functions) are managed by stow
  # from ~/dotfiles instead, so this stays off to avoid fighting over ~/.zshrc.
  programs.zsh.enable = false;
  programs.caelestia = {
    enable = true;
    cli.enable = true;
    systemd.enable = false;
  };
  # or, alternatively, set it in `.ssh/config` which has higher precedence:
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      identityAgent = "/home/daw/.1password/agent.sock";
    };
  };
  # git config (.gitconfig) is managed by stow from ~/dotfiles instead, so
  # this stays off to avoid fighting over ~/.config/git/config.
  programs.git.enable = false;
  programs.k9s.enable = true;
}
