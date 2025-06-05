# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
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
    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 10;
      };
      enableGitIntegration = true;
      themeFile = "OneDark";
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
      extraConfig = {core.editor = "nvim";};
    };

    i3status-rust = {
      enable = true;
      bars = {
        top = {
          blocks = [
            {block = "cpu";}
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

    jetbrains-toolbox
  ];

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
