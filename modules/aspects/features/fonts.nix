# The everyday font is small; the larger collection is an explicit opt-in.
{
  den.aspects.features = {
    fonts.homeManager = {pkgs, ...}: {
      home.packages = [pkgs.nerd-fonts.commit-mono];
    };
    fonts-extra.homeManager = {pkgs, ...}: {
      home.packages = with pkgs.nerd-fonts; [
        agave
        geist-mono
        blex-mono
        jetbrains-mono
        monaspace
      ];
    };
  };
}
