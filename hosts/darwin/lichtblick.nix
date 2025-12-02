{ config, lib, pkgs, nixpkgs, inputs, ... }:
{
  imports = [
    ./common.nix # some abstracted common darwin functionality. could be made a bit nicer through auto import or a module I guess
  ];

  # host specific nix-darwin config goes below

  modules = {
    fonts.enable = false;
    hunspell.enable = false;
    nix.enable = true;
    socketVmnet.enable = true;
  };

  # documentation.info.enable = false;

  # zsh completions
  environment.pathsToLink = [ "/share/zsh" ];

  networking.hostName = "Stefan-Keidel-MacBook-Pro";

  # Enable firewall
  # networking.applicationFirewall = {
  #   enable = true;
  #   blockAllIncoming = true;
  # };

  nix.settings.trusted-users = [ "root" "stefan.keidel@lichtblick.de" ];

  system.primaryUser = "stefan.keidel@lichtblick.de";
  users.users.stefan = {
    home = "/Users/stefan.keidel@lichtblick.de";
  };

  home-manager.users."stefan" = ./. + "/../../users/darwin/stefan@lichtblick.nix";
}
