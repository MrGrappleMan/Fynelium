{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
 
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
system.autoUpgrade.channel = "https://nixos.org/channels/nixpkgs-unstable"
system.autoUpgrade.dates = "daily"


 # Boot
 boot.loader.systemd-boot.enable = true;
 boot.loader.systemd-boot.memtest86.enable = true;
 boot.loader.systemd-boot.configurationLimit = 4;
 boot.loader.efi.canTouchEfiVariables = true;
  
# System.Power
services.tlp.enable = true;
services.power-profiles-daemon.enable = false;
powerManagement.enable = true;

# HID.Visual
services.xserver.enable = false;
programs.niri.enable = true;
services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
    autoSuspend = true;
  };
services.displayManager.autoLogin.enable = true;
services.displayManager.autoLogin.user = "a";
programs.xwayland.enable = true;
services.xserver.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };

# HID.Auditory
services.pipewire.enable = true;
services.pipewire.wireplumber.enable = true;
services.pipewire.jack.enable = true;
services.pipewire.pulse.enable = true;
services.pipewire.systemWide = true;
services.pulseaudio.enable = false;
hardware.alsa.enable = false;
services.jack.alsa.enable = false;

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
  # Use nixos-unstable and nixpkgs-unstable properly

  # Wayland-only
  
  
  
  # Configure keymap for Wayland
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing support
  services.printing.enable = true;


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
