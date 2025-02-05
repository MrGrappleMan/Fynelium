{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
 # Note:
# This configuration is only for optimizing the base system 
# Human Interface Hardware and Software will not be tweaked
 # Other
 services.tor.relay.enable = true;
 services.boinc.enable = true;
 services.ollama.enable = true;
 hardware.system76.kernel-modules.enable = true;
 services.flatpak.enable = true;
 xdg.portal.enable = true;
 system.autoUpgrade.enable = true;
system.autoUpgrade.persistent = true;
system.autoUpgrade.operation = "switch";
system.autoUpgrade.allowReboot = false;
system.autoUpgrade.channel = "https://nixos.org/channels/nixpkgs-unstable";
system.autoUpgrade.dates = "daily";

 # Boot
 boot.loader.systemd-boot.enable = true;
 boot.loader.systemd-boot.memtest86.enable = true;
 boot.loader.systemd-boot.configurationLimit = 2;
 boot.loader.efi.canTouchEfiVariables = true;
  
# System.Power
services.tlp.enable = true;
services.power-profiles-daemon.enable = false;
powerManagement.enable = true;

 # Networking
 networking.hostName = "Fyn-Device";
 networking.networkmanager.enable = true;

 # Time and locale
 services.timesyncd.enable = true;
  
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Define a user
  users.users.a = {
    isNormalUser = true;
    description = "a";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Add user packages here
    ];
  };

  # Enable auto-login (Updated option name)
  

  # Install Firefox (from unstable)
  programs.firefox.enable = true;
  
  system.stateVersion = "unstable";
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
