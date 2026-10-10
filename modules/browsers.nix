{ ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  # BROWSER POLICIES
  environment.etc."chromium/policies/managed/helium.json".text = builtins.toJSON {
    DefaultSearchProviderEnabled = true;
    DefaultSearchProviderName = "Google";
    DefaultSearchProviderSearchURL = "https://www.google.com/search?q={searchTerms}";
    DefaultSearchProviderSuggestURL = "https://www.google.com/complete/search?client=chrome&q={searchTerms}";
    SearchSuggestEnabled = true;
    ExtensionInstallSources = [ "https://services.helium.imput.net/*" ];
    ExtensionInstallForcelist = [
      "nngceckbapebfimnlniiiahkandclblb"
      "aapbdbdomjkkjkaonfhkkikfgjllcleb"
      "dbepggeogbaibhgnhhndojpepiihcmeb"
    ];
  };
  environment.etc."opt/chrome/policies/managed/chrome.json".text = builtins.toJSON {
    DefaultBrowserSettingEnabled = false;
    MetricsReportingEnabled = false;
    BrowserSignin = 0;
  };
  environment.etc."brave/policies/managed/brave.json".text = builtins.toJSON {
    DefaultBrowserSettingEnabled = false;
    MetricsReportingEnabled = false;
    BraveStatsPingEnabled = false;
  };
}
