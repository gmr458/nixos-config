{ lib, stdenv, fetchurl, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "kotlin-lsp";
  version = "263.6379.0";

  src = fetchurl {
    url = "https://download.jetbrains.com/language-server/kotlin-server/${version}/kotlin-server-${version}.tar.gz";
    hash = "sha256-q4ykRV3C/F/hok2yvMxGwQQlTSxGUVXEJR7mXfjz98w=";
  };

  nativeBuildInputs = [ makeWrapper ];
  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  dontStrip = true; # leave the bundled JBR and native libs alone

    installPhase = ''
    runHook preInstall

    mkdir unpacked
    tar -xzf $src -C unpacked

    launcher=$(find unpacked -path '*/bin/intellij-server' | head -n1)
    root=$(dirname "$(dirname "$launcher")")

    mkdir -p $out/lib/kotlin-lsp $out/bin
    cp -r "$root"/. $out/lib/kotlin-lsp

    makeWrapper $out/lib/kotlin-lsp/bin/intellij-server $out/bin/intellij-server
    ln -s intellij-server $out/bin/kotlin-lsp

    runHook postInstall
  '';

    meta = {
    description = "Kotlin language server by JetBrains";
    homepage = "https://github.com/Kotlin/kotlin-lsp";
    license = with lib.licenses; [ asl20 unfree ]; # repo is Apache-2.0, binary bundles proprietary parts
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode binaryBytecode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "intellij-server";
  };
}
