{
  config,
  outputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config.allowUnfree = true;
    config.permittedInsecurePackages = ["openssl-1.1.1w"];
  };
}
