{pkgs, inputs, ...}:

{
  programs.spicetify = 
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;
    theme = spicePkgs.themes.gruvbox-material-dark;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle
    ];
  };
}
