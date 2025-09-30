{
  pkgs,
  config,
  lib,
  ...
}: {
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
    ];
  };

  # Optional: Install language tooling
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
  ];
}
