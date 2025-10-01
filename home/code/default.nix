{ pkgs, config, lib, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # Python
      ms-python.python
      ms-python.vscode-pylance
      # C/C++
      ms-vscode.cpptools
      # Go
      golang.go
      # Nix
      jnoortheen.nix-ide
      # Utility
      mkhl.direnv  # For auto-loading shell.nix environments
    ];

    userSettings = {
      # Nix IDE settings
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
      "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
      "[nix]" = {
        "editor.tabSize" = 2;
        "editor.formatOnSave" = true;
      };
    };
  };

  # Language tooling
  home.packages = with pkgs; [
    # Python
    python3
    python3Packages.pip
    # C++
    gcc
    clang-tools
    cmake
    # Go
    go
    gopls
    delve
    # Nix
    nixd         # Nix language server
    alejandra    # Nix formatter
    nil          # Alternative Nix language server (optional)
  ];
}
