# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./i3.nix
  ];

  # nixpkgs = {
  # You can add overlays here
  #    overlays = [
  # If you want to use overlays exported from other flakes:
  # neovim-nightly-overlay.overlays.default

  # Or define it inline, for example:
  # (final: prev: {
  #   hi = final.hello.overrideAttrs (oldAttrs: {
  #     patches = [ ./change-hello-to-hi.patch ];
  #   });
  # })
  #    ];
  # Configure your nixpkgs instance
  # config = {
  # Disable if you don't want unfree packages
  # allowUnfree = true;
  # Workaround for https://github.com/nix-community/home-manager/issues/2942
  # allowUnfreePredicate = _: true;
  # };
  # };

  # TODO: Set your username
  home = {
    username = "isc740";
    homeDirectory = "/home/isc740";
  };

  programs = {

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        nixbuild = "sudo nixos-rebuild switch --flake ~/nix/#nixos";
        nixupdate = "sudo nix flake update ~/nix/";
        ll = "ls -la";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "dirhistory"
          "history"
        ];
      };
      initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        ${(builtins.readFile ./p10k.zsh)}
      '';

    };

    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 10;
      };
      settings = {
        adjust_line_height = 4;
        dynamic_background_opacity = true;
        background_opacity = 0.5;
        confirm_os_window_close = 0;
      };
      extraConfig = ''
        foreground #a6accd
        background #1B1E28

        # Black
        color0 #1b1e28
        color8 #a6accd

        # Red
        color1 #d0679d
        color9 #d0679d

        # Green
        color2  #5de4c7
        color10 #5de4c7

        # Yellow
        color3  #fffac2
        color11 #fffac2

        # Blue
        color4  #89ddff
        color12 #add7ff

        # Magenta
        color5  #fcc5e9
        color13 #fae4fc

        # Cyan
        color6  #add7ff
        color14 #89ddff

        # White
        color7  #ffffff
        color15 #ffffff

        # Cursor
        cursor #ffffff
        cursor_text_color #1b1e28

        # Selection highlight
        selection_foreground none
        selection_background #28344a

        # The color for highlighting URLs on mouse-over
        # url_color #9ece6a
        url color #5de4c7

        # Window borders
        active_border_color #3d59a1
        inactive_border_color #101014
        bell_border_color #fffac2

        # Tab bar
        tab_bar_style fade
        tab_fade 1
        active_tab_foreground   #3d59a1
        active_tab_background   #16161e
        active_tab_font_style   bold
        inactive_tab_foreground #787c99
        inactive_tab_background #16161e
        inactive_tab_font_style bold
        tab_bar_background #101014

        # Title bar
        macos_titlebar_color #16161e

      '';
      enableGitIntegration = true;
    };

    vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        jnoortheen.nix-ide
        # llvm-vs-code-extensions.vscode-clangd
        # haskell.haskell
        biomejs.biome
        denoland.vscode-deno
        christian-kohler.path-intellisense
        pkief.material-icon-theme
        # abusaidm.html-snippets
        ecmel.vscode-html-css
        # burkeholland.simple-react-snippets
        bradlc.vscode-tailwindcss
        # stivo.tailwind-fold
        # austenc.tailwind-docs
        # Catppuccin.catppuccin-vsc
        # xabikos.JavaScriptSnippets
        # gmcdermott.vscode-language-babel
        # skyran.js-jsx-snippets
      ];
    };

    git = {
      enable = true;
      userName = "Isc740";
      userEmail = "isaazcantillo@gmail.com";
      extraConfig = {
        core.editor = "nvim";
      };
    };

    i3status-rust = {
      enable = true;
      bars = {
        top = {
          blocks = [
            { block = "cpu"; }
            {
              block = "disk_space";
              path = "/";
              info_type = "available";
              interval = 20;
              warning = 20.0;
              alert = 10.0;
              format = " $icon root: $available.eng(w:2) ";
            }
            {
              block = "memory";
              format = " $icon $mem_total_used_percents.eng(w:2) ";
              format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
            }
            {
              block = "sound";
              click = [
                {
                  button = "left";
                  cmd = "pavucontrol";
                }
              ];
            }
            {
              block = "time";
              interval = 5;
              format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            }
          ];
        };
      };
    };

  };

  home.packages = with pkgs; [
    zsh-powerlevel10k
    fastfetch
    neofetch
    p7zip
    unzip
    unrar
    flameshot
    htop
    xclip
    steamcmd
    steam-tui
    pulsemixer
    wget
    lf
    dbeaver-bin
    ripgrep
    jq
    eza
    which
    tree
    nix-output-monitor
    glow

    hoppscotch

    lazysql

    httpie-desktop
    httpie

    dia
    obsidian
  ];

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
