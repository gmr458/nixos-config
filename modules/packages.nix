{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    alacritty
    bat
    biome
    bitwarden-desktop
    (brave.override {
      commandLineArgs = "--no-first-run --no-default-browser-check";
    })
    (brave-origin.override {
      commandLineArgs = "--no-first-run --no-default-browser-check";
    })
    bruno
    btop
    bun
    carapace
    chromium
    bubblewrap
    codex
    czkawka
    deno
    difftastic
    dnsutils
    dmidecode
    fastfetch
    fd
    ffmpeg
    file
    foliate
    foot
    fzf
    ghostty
    gcc
    gh
    git
    gnumake
    gnupg
    go_1_27
    gofumpt
    golangci-lint
    (google-chrome.override {
      commandLineArgs = "--no-first-run --no-default-browser-check";
    })
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
    nixfmt
    nixfmt-tree
    noctalia
    nodejs
    nushell
    obsidian
    odin
    onefetch
    opencode
    openssl
    pkg-config
    pnpm
    prettier
    python3
    ripgrep
    rustup
    showmethekey
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
    tmux
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
