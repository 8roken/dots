{ config, lib, pkgs, ... }:

{
  users.users.broken = {
    isNormalUser = true;
    extraGroups = [ "wheel"];
    shell = pkgs.zsh;
  };

  # This is so that NixOs automatically login to this user and doesn't require
  # to login everytime the computer turns on.
  services.getty.autologinUser = "broken";

  systemd.user.services.uwsm = {
    enable = true;
    after = [ "getty.target" ];
    wantedBy = [ "default.target" ];
    description = "UWSM Auto Launch";
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "no";
      StandardOutput = "journal";
      ExecStart = "/run/current-system/sw/bin/uwsm start default";
    };
  };
}
