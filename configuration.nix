{
  pkgs,
  inputs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  # NIX
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://ghostty.cachix.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    trusted-users = [
      "@wheel"
    ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;
  nixpkgs.config.allowUnfree = true;

  # BOOT
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

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
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
  programs.niri.enable = true;
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;

  # BROWSER POLICIES
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
  environment.etc."opt/chrome/policies/managed/chrome.json".text = builtins.toJSON {
    DefaultBrowserSettingEnabled = false;
    MetricsReportingEnabled = false;
    BrowserSignin = 0;
  };
  environment.etc."brave/policies/managed/brave.json".text = builtins.toJSON {
    DefaultBrowserSettingEnabled = false;
    MetricsReportingEnabled = false;
    BraveStatsPingEnabled = false;
  };

  # ENVIRONMENT
  environment.sessionVariables = {
    PNPM_HOME = "$HOME/.local/share/pnpm";
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "Adwaita";
  };
  environment.systemPackages = with pkgs; [
    alacritty
    bat
    (brave.override {
      commandLineArgs = "--no-first-run --no-default-browser-check";
    })
    (brave-origin.override {
      commandLineArgs = "--no-first-run --no-default-browser-check";
    })
    bruno
    btop
    bun
    calibre
    carapace
    chromium
    deno
    fastfetch
    fd
    ffmpeg
    file
    foot
    fzf
    gcc
    git
    gnumake
    go
    (google-chrome.override {
      commandLineArgs = "--no-first-run --no-default-browser-check";
    })
    handbrake
    imagemagick
    jq
    just
    k6
    kitty
    kooha
    kotlin-cli
    lsd
    lua
    luajit
    mpv
    neovide
    nixfmt
    noctalia
    nodejs
    nushell
    obsidian
    odin
    onefetch
    opencode
    pkg-config
    pnpm
    prettier
    python3
    ripgrep
    rustup
    spotify
    sqlite
    sqlitebrowser
    stow
    stylua
    sublime4
    telegram-desktop
    tokei
    tree
    tree-sitter
    unzip
    vim
    vivid
    vlc
    vscodium
    wget
    wl-clipboard
    xnviewmp
    (makeDesktopItem {
      name = "xnviewmp";
      desktopName = "XnView Multi Platform";
      genericName = "XnViewMP";
      exec = "xnviewmp %F";
      icon = "xnviewmp";
      comment = "An efficient multimedia viewer, browser and converter";
      categories = [
        "Graphics"
        "Viewer"
      ];
      mimeTypes = import ./mime-images.nix;
    })
    xwayland-satellite
    yt-dlp
  ];

  # FONTS
  fonts.packages = with pkgs; [
    inter
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
    nerd-fonts.zed-mono
    roboto
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Roboto" ];
      serif = [ "Roboto" ];
      monospace = [ "Iosevka Nerd Font Mono" ];
    };
  };

  # SYSTEM
  system.stateVersion = "26.05";
}
