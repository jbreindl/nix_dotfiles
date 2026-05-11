{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (pkgs.symlinkJoin {
      name = "whatsapp-electron";
      paths = [ whatsapp-electron ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/whatsapp-electron \
            --add-flags "--no-sandbox"
      '';
    })
    firefox
    wezterm
  ];

}
