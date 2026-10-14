{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    astro-language-server
    # bash-language-server
    # buf
    # clang-tools
    vscode-langservers-extracted 
    dockerfile-language-server 
    # elixir-ls
    golangci-lint-langserver 
    gopls 
    intelephense 
    (callPackage ../pkgs/kotlin-lsp.nix { }) 
    lua-language-server
    ols
    # omnisharp-roslyn
    # postgres-language-server
    pyright
    ruff
    rust-analyzer
    svelte-language-server
    tailwindcss-language-server
    taplo
    # templ
    typescript
    typescript-language-server
    yaml-language-server
  ];
}
