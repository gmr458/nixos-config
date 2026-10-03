{ lib, ... }:
{
  home.username = "gdmr";
  home.homeDirectory = "/home/gdmr";
  home.stateVersion = "26.05";

  # Overwrites Preferences on each activation; sessions/extensions live in
  # separate files so they survive. Must stay a writable copy, not a symlink.
  home.activation.heliumPrefs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/net.imput.helium/Default"
    cat > "$HOME/.config/net.imput.helium/Default/Preferences" <<'EOF'
    ${builtins.toJSON {
      helium.completed_onboarding = true;
      helium.browser.rounded_frame = false;

      helium.services.enabled = true;
      helium.services.user_consented = true;
      helium.services.schema_version = 1;
      helium.services.extension_updating = true;
      helium.services.bangs_enabled = true;
      helium.services.ublock_assets = true;
      helium.services.update_fetching_enabled = true;
      helium.services.spellcheck_files = true;
    }}
    EOF
  '';
}
