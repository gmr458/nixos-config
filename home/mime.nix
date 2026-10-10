{ lib, ... }:
{
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
}
