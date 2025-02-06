{ config, pkgs, ... }:

{
  # Imports
  imports = [
    ./hardware-configuration.nix
  ];

  # System settings
  system.stateVersion = "unstable";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto-upgrade
  system.autoUpgrade = {
    enable = true;
    persistent = true;
    operation = "switch";
    allowReboot = false;
    channel = "https://nixos.org/channels/nixpkgs-unstable";
    dates = "daily";
  };

  # Boot configuration
  boot.loader.systemd-boot = {
    enable = true;
    memtest86.enable = true;
    configurationLimit = 2;
    efi.canTouchEfiVariables = true;
  };

  # Power management
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;
  powerManagement.enable = true;

  # Services
  services = {
    # Networking
    networking.hostName = "Fyn-Device";
    networking.networkmanager.enable = true;

    # Timesync and locale
    timesyncd.enable = true;
    time.timeZone = "Asia/Kolkata";
    i18n = {
      defaultLocale = "en_IN";
      extraLocaleSettings = {
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

    kubo.enable = true;
    snowflake-proxy.enable = true;
    
    boinc.enable = true;
    ollama.enable = true;

    # Flatpak & XDG
    flatpak.enable = true;
    xdg.portal.enable = true;

    # Printing
    printing.enable = true;
  };

  # User configuration
  users.users.a = {
    isNormalUser = true;
    description = "a";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Add user packages here
    ];
  };
  programs.firefox.enable = true;
  # Kernel modules and system configuration
  hardware.system76.kernel-modules.enable = true;
programs.ccache.enable = true;
services.distccd.enable = true;
services.distccd.stats.enable = true;
services.distccd.nice = 19;
services.preload.enable = true;
programs.nix-ld.enable = true;
}