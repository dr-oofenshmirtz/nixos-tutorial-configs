# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  username = "yolo";
in
{
  ####### ====================================
  ###                 VM ONLY
  ####### ====================================

  virtualisation.virtualbox.guest.enable = true;

  ####### ====================================
  ###                 system
  ####### ====================================

  system.stateVersion = "22.05"; # Did you read the comment?

  imports =
    [ # Include the results of the hardware scan.
      #<home-manager/nixos>
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  ####### ====================================
  ###                 networking
  ####### ====================================

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  ####### ====================================
  ###                 Internationalization
  ####### ====================================

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.utf8";

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  ####### ====================================
  ###                 display
  ####### ====================================

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  ####### ====================================
  ###                 system
  ####### ====================================

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #media-session.enable = true;
  };

  ####### ====================================
  ###                 User
  ####### ====================================

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
    initialPassword = "passwd";
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  ####### ====================================
  ###                 Services
  ####### ====================================
  ## This is an alternative to pkgs. Use this for things to start with systemd
  ## These things are daemonized by default

  # services.openssh.enable = true;

  ####### ====================================
  ###                 Garbage Collection
  ####### ====================================
  ## not nessecary, but also totally nessecary
  ## This deletes old config instances and old application versions
  ## To allow yourself to rollback to arbitrary versions 
  ## all previous versions are saved by default
  ## This will gradually fill your harddrive

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  ####### ====================================
  ###                 Home Manager
  ####### ====================================
  ## will not work with flakes
  ## Flakes will also not need the home manager channel
  #home-manager.users.${username} = { pkgs, ... }: {
    # home manager stuff here
    # home.packages = [ pkgs.htop ]; These two things are the same
    #home.packages = with pkgs; [ htop ];
  #};

  
  ####### ====================================
  ###                 flakes
  ####### ====================================

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
