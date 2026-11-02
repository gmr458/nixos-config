{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    bat
    biome
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
    czkawka
    deno
    difftastic
    dnsutils
    fastfetch
    fd
    ffmpeg
    file
    foliate
    foot
    fzf
    ghostty
    gcc
    git
    gnumake
    go_1_27
    gofumpt
    golangci-lint
    (google-chrome.override {
      commandLineArgs = "--no-first-run --no-default-browser-check";
    })
    # handbrake
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
    noctalia
    nodejs
    nushell
    # Electron 43 breaks Obsidian 1.14.5's renderer: `webFrame` fails to
    # initialize with "Cannot read properties of undefined (reading
    # 'defineProperty')". Pin to the newest supported Electron for now.
    (obsidian.override { electron = electron_42; })
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
