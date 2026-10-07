{ lib, ... }:
{
  home.username = "gdmr";
  home.homeDirectory = "/home/gdmr";
  home.stateVersion = "26.05";
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      let
        browser = [ "helium.desktop" ];
        images = [ "xnviewmp.desktop" ];
        video = [ "vlc.desktop" ];
        audio = [ "vlc.desktop" ];
      in
      {
        "text/html" = browser;
        "application/xhtml+xml" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;

        "application/pdf" = [ "org.gnome.Papers.desktop" ];
        "application/epub+zip" = [ "calibre-ebook-viewer.desktop" ];
        "application/x-mobipocket-ebook" = [ "calibre-ebook-viewer.desktop" ];

        "image/avif" = images;
        "image/bmp" = images;
        "image/gif" = images;
        "image/heic" = images;
        "image/heif" = images;
        "image/jp2" = images;
        "image/jpeg" = images;
        "image/jxl" = images;
        "image/png" = images;
        "image/svg+xml" = images;
        "image/tiff" = images;
        "image/vnd.adobe.photoshop" = images;
        "image/vnd.microsoft.icon" = images;
        "image/vnd.radiance" = images;
        "image/webp" = images;
        "image/x-adobe-dng" = images;
        "image/x-canon-cr2" = images;
        "image/x-canon-cr3" = images;
        "image/x-canon-crw" = images;
        "image/x-dds" = images;
        "image/x-exr" = images;
        "image/x-fuji-raf" = images;
        "image/x-nikon-nef" = images;
        "image/x-nikon-nrw" = images;
        "image/x-olympus-orf" = images;
        "image/x-panasonic-rw2" = images;
        "image/x-pentax-pef" = images;
        "image/x-samsung-srw" = images;
        "image/x-sony-arw" = images;
        "image/x-tga" = images;
        "image/x-xcf" = images;

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
