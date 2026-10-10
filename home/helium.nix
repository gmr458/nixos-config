{ lib, pkgs, ... }:
{
  home.activation.heliumPrefs =
    let
      prefs = pkgs.writeText "helium-prefs.json" (
        builtins.toJSON {
          helium.completed_onboarding = true;
          helium.browser.rounded_frame = false;
          helium.services = {
            enabled = true;
            user_consented = true;
            schema_version = 1;
            extension_updating = true;
            bangs_enabled = true;
            ublock_assets = true;
            update_fetching_enabled = true;
            spellcheck_files = true;
          };
        }
      );
      mergeScript = pkgs.writeText "helium-merge.nu" ''
        def main [prefs: path, target: path] {
          # Browser is running and would overwrite our changes on exit
          if ($target | path exists) and (ps | where name == 'helium' | is-not-empty) {
            print "Helium is running, skipping Preferences merge"
            return
          }

          mkdir ($target | path dirname)

          let ours = open --raw $prefs | from json

          # Missing, empty or corrupt file falls back to our keys only,
          # keeping a copy of whatever was there first
          let merged = try {
            open --raw $target | from json | merge deep $ours
          } catch {
            if ($target | path exists) {
              ^${pkgs.coreutils}/bin/cp -f $target $"($target).bak"
            }
            $ours
          }

          # Write next to the target, then rename, so a crash can't leave a partial file
          let tmp = $"($target).hm-tmp"
          $merged | to json --raw | save --force $tmp
          ^${pkgs.coreutils}/bin/chmod 600 $tmp
          ^${pkgs.coreutils}/bin/mv -f $tmp $target
        }
      '';
    in
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run ${pkgs.nushell}/bin/nu ${mergeScript} ${prefs} "$HOME/.config/net.imput.helium/Default/Preferences"
    '';
}
