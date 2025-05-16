{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
     ./nvidia.nix
     ./users.nix
     ./hyprland.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hopes";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Montreal";

   services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
   };

   environment.systemPackages = with pkgs; [
     vim
     fish
     wget
     git
     home-manager
   ];


programs = {
  zsh.enable = true;
  sway.enable = true;
  uwsm.enable = true;
  gnugp.agent = {
    enable = true;
    enableSSHSupport = false; # for now...
  };
};

fonts = {
 packages = with pkgs; [ nerdfonts ];
 fontconfig = {
    defaultFonts = {
      serif = [  "Liberation Serif" "Vazirmatn" ];
      sansSerif = [ "Ubuntu" "Vazirmatn" ];
      monospace = [ "Ubuntu Mono" ];
    };
  };
};

  system.copySystemConfiguration = true;
  system.stateVersion = "24.11"; # Frozen!
}

