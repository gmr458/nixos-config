{ lib, pkgs, ... }:
{
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
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      let
        browser = [ "helium.desktop" ];
        images = [ "xnviewmp.desktop" ];
        video = [ "vlc.desktop" ];
        audio = [ "vlc.desktop" ];
        imageTypes = import ./mime-images.nix;
      in
      lib.genAttrs imageTypes (_: images)
      // {
        "text/html" = browser;
        "application/xhtml+xml" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;

        "application/pdf" = [ "org.gnome.Papers.desktop" ];
        "application/epub+zip" = [ "calibre-ebook-viewer.desktop" ];
        "application/x-mobipocket-ebook" = [ "calibre-ebook-viewer.desktop" ];

        "video/mp4" = video;
        "video/x-matroska" = video;
        "video/webm" = video;
        "video/x-msvideo" = video;
        "video/quicktime" = video;
        "video/mpeg" = video;

        "audio/mpeg" = audio;
        "audio/flac" = audio;
        "audio/ogg" = audio;
        "audio/x-wav" = audio;
        "audio/mp4" = audio;
        "audio/aac" = audio;

        "text/plain" = [ "org.gnome.TextEditor.desktop" ];
      };
  };
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
