{ pkgs, ... }:

{
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
}
