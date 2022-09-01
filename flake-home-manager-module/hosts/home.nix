{ config, pkgs, user, ... } :


{
  home = {
    stateVersion = "22.05";
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      firefox

      feh
      mpv
      vlc   
    ];
  };
  
  programs = {
    home-manager.enable = true;
  };

  xsession = {
    enable = true;
  };
}
