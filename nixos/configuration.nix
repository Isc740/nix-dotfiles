# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CO.UTF-8";
    LC_IDENTIFICATION = "es_CO.UTF-8";
    LC_MEASUREMENT = "es_CO.UTF-8";
    LC_MONETARY = "es_CO.UTF-8";
    LC_NAME = "es_CO.UTF-8";
    LC_NUMERIC = "es_CO.UTF-8";
    LC_PAPER = "es_CO.UTF-8";
    LC_TELEPHONE = "es_CO.UTF-8";
    LC_TIME = "es_CO.UTF-8";
  };

  environment = {
    pathsToLink = [ "/libexec" ];
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
      PATH = "$HOME/.local/share/pnpm/bin/:$PATH";
    };
  };

  # Configure keymap in X11
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "altgr-intl";
      };
      windowManager.i3 = {
        enable = true;
        # extraPackages = with pkgs; [ i3status ];
      };
      desktopManager = {
        xterm.enable = true;
        # xfce = {
        #   enable = true;
        #   noDesktop = true;
        #   enableXfwm = false;
        # };
      };
    };

    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    libinput = {
      enable = true;
      mouse.middleEmulation = false;
    };
  };

  # FONTS
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-emoji
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.isc740 = {
    isNormalUser = true;
    description = "Isc740";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      firefox
      xarchiver
      btop
      jetbrains.rider
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    lf
    gnome-keyring
    pulseaudioFull
    rofi
    unrar
    unzip
    pavucontrol
    dmenu
    udisks
    nixfmt-rfc-style
    dunst
    xmousepasteblock
    temurin-jre-bin-24
    temurin-jre-bin-17
    temurin-jre-bin-8
    openssl

    # prisma-language-server
    dotnet-sdk_8
    dotnet-sdk_9
    icu
  ];

  programs = {
    thunar.enable = true;
    dconf.enable = true;
    neovim.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.displayManager = {
    ly.enable = true;
    defaultSession = "none+i3";
  };

  # services.postgresql = {
  #   enable = true;
  #   ensureDatabases = [
  #     "mydatabase"
  #     "test_userdb"
  #   ];
  #   ensureUsers = [
  #     {
  #       name = "isc740";
  #       ensureClauses = {
  #         login = true;
  #         createdb = true;
  #         createrole = true;
  #       };
  #     }
  #   ];
  #
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     # TYPE  DATABASE  USER      ADDRESS      METHOD
  #     local   all       all                     trust    # Unix socket
  #     host    all       all       127.0.0.1/32  trust    # IPv4 localhost
  #     host    all       all       ::1/128       trust    # IPv6 localhost
  #   '';
  # };

  # services.mysql = {
  #   enable = true;
  #   package = pkgs.mariadb;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
