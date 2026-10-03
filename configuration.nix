{ pkgs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # NIX
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [ "https://ghostty.cachix.org" ];
    trusted-public-keys = [ "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns=" ];
  };
  nixpkgs.config.allowUnfree = true;

  # BOOT
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NETWORKING
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # LOCALE / TIME / KEYMAP
  time.timeZone = "America/Bogota";
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
  console.keyMap = "la-latin1";
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };

  # DESKTOP / AUDIO / PRINTING / POWER
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.printing.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # USERS
  users.users."gdmr" = {
    isNormalUser = true;
    description = "gdmr";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  # PROGRAMS
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/settings-daemon/plugins/power" = {
          idle-dim = false;
        };
        "org/gnome/desktop/session" = {
          idle-delay = lib.gvariant.mkUint32 0;
        };
        "org/gnome/desktop/peripherals/keyboard" = {
          repeat = true;
          delay = lib.gvariant.mkUint32 200;
          repeat-interval = lib.gvariant.mkUint32 31;
        };
      };
    }
  ];
  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
  programs.niri.enable = true;
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;

  # BROWSER POLICIES
  # Helium reads Chromium's policy path, not its own config dir.
  environment.etc."chromium/policies/managed/helium.json".text = builtins.toJSON {
    DefaultSearchProviderEnabled = true;
    DefaultSearchProviderName = "Google";
    DefaultSearchProviderSearchURL = "https://www.google.com/search?q={searchTerms}";
    DefaultSearchProviderSuggestURL = "https://www.google.com/complete/search?client=chrome&q={searchTerms}";
    SearchSuggestEnabled = true;

    ExtensionInstallSources = [ "https://services.helium.imput.net/*" ];
    ExtensionInstallForcelist = [
      "nngceckbapebfimnlniiiahkandclblb"
      "aapbdbdomjkkjkaonfhkkikfgjllcleb"
      "dbepggeogbaibhgnhhndojpepiihcmeb"
    ];
  };

  # ENVIRONMENT
  environment.sessionVariables = {
    EDITOR = "nvim";
    PNPM_HOME = "$HOME/.local/share/pnpm";
  };
  environment.systemPackages = with pkgs; [
    alacritty
    bat
    bun
    carapace
    deno
    fastfetch
    fd
    file
    fzf
    gcc
    git
    go
    kitty
    lsd
    neovide
    nixfmt
    noctalia
    nodejs
    nushell
    onefetch
    opencode
    pkg-config
    pnpm
    python3
    ripgrep
    rustup
    stow
    stylua
    sublime4
    tokei
    tree-sitter
    vim
    vscodium
    vivid
    wget
    wl-clipboard
  ];

  # FONTS
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
    nerd-fonts.zed-mono
  ];

  # SYSTEM
  system.stateVersion = "26.05";
}
