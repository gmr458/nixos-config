{ pkgs, inputs, ... }:

{
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

  programs.niri.enable = true;
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  environment.sessionVariables = {
    PNPM_HOME = "$HOME/.local/share/pnpm";
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "Adwaita";
  };
}
