{ config, lib, pkgs, systemName, ... }:
{
  imports = [
    ../common/stefan.nix
    ./stefan_darwin.nix
  ];

  # markus' modules are nice but I'm not there yet
  modules = {
    emacs.enable = false;
    tmux = {
      enable = false;
      copyCommand = "pbcopy";
      shell = "${pkgs.fish}/bin/fish";
    };
    fish = {
      enable = false;
      extraInit = ''
        ${pkgs.mise}/bin/mise activate fish | source
      '';
    };
    zsh = {
      enable = false;
      extraInit = ''
        eval "$(${pkgs.mise}/bin/mise activate zsh)"
      '';
    };
  };

  home = {
    packages = with pkgs; [
      ffmpeg
      mosh
      ghostscript
      streamlink
      vfkit
      yt-dlp
      qemu
      # VMs
      (lib.buildQemuVm {
        name = "docker";
        targetSystem = "aarch64-linux";
        configuration = {
          imports = [
            ../../vms/nixos/docker.nix
          ];
          virtualisation.diskImage = "/Users/stefan/var/docker.qcow2";
        };
      })
    ];
  };
}
