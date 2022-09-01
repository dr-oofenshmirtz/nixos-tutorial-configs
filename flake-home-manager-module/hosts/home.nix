{ config, pkgs, user, ... } :


{
  home = {
    stateVersion = "22.05";
    username = "${user}";
    homeDirectory = "/home/${user}";
    systemPackages = with pkgs; [
      feh
      mpv
      vlc   
    ];
  };
  
  programs = {
    home-manager.enable = true;
  }

  xsession = {
    enable = true;
  }
}
