{ config, pkgs, ... }:

let pkgs = import <nixpkgs> {
  config.allowUnfree = true;
};

in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "broken";
  home.homeDirectory = "/home/broken";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.firefox
    pkgs.vivaldi
    pkgs.spotify
    pkgs.rofi
    pkgs.neovim
    pkgs.playerctl
    pkgs.gcc
    pkgs.zig
    pkgs._1password-cli
    pkgs._1password-gui
    pkgs.dolphin
    pkgs.vscode
    pkgs.qt6ct
    pkgs.fastfetch
    pkgs.fzf

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
  #  /etc/profiles/per-user/pier-olivier/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = "no";
      enable_layouts = "horizontal";

      tab_bar_edge = "top";
      tab_bar_min_tabs = "2";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      font_size = "12.0";
      font_family = "Hack Nerd Font";
      window_margin_width = 4;

      include = "current-theme.conf";
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = builtins.readFile ./waybar.css;
    settings = [{
      height = 30;
      spacing = 4;
      modules-center = [ "clock" ];
      modules-left = [ "hyprland/workspaces" ];
      modules-right = ["pulseaudio" "network"];
      clock = {
        format = "{:%a %d %b %R}";
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-bluetooth = "{icon} {volume}%";
        format-bluetooth-muted = "{icon} ";
        format-icons = {
          car = "";
          default = [ "" "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = " {format_source}";
        format-source-muted = "";
        on-click = "pavucontrol";
      };
      network = {
        interval = 1;
        format-alt = "{essid}: {ipaddr}/{cidr}({ifname})";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = " {signalStrength}%";
      };
    }];
  };
}
