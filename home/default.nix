{ lib, ... }:
{
  imports = [
    ./mime.nix
    ./helium.nix
  ];

  home.username = "gdmr";
  home.homeDirectory = "/home/gdmr";
  home.stateVersion = "26.05";
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/power".idle-dim = false;
    "org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 0;
    "org/gnome/desktop/peripherals/keyboard" = {
      repeat = true;
      delay = lib.hm.gvariant.mkUint32 200;
      repeat-interval = lib.hm.gvariant.mkUint32 31;
    };
    "org/gnome/desktop/interface" = {
      font-name = "Roboto 11";
      document-font-name = "Roboto 11";
      monospace-font-name = "Iosevka Nerd Font Mono 11";
      cursor-theme = "Adwaita";
      cursor-size = lib.hm.gvariant.mkInt32 24;
    };
  };
}
