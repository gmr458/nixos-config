{ pkgs, inputs, ... }:

{
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
    ghostty
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
      mimeTypes = import ../home/mime-images.nix;
    })
    xwayland-satellite
    yt-dlp
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
