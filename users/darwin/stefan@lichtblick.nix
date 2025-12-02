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
      duckdb
      k9s
      kubectl
      kubectx
      kubernetes-helm
      (writeShellScriptBin "do_bak" ''
        #!/usr/bin/env zsh
        set -e
        restic --password-file ~/.config/restic-pw --repo rclone:sb:lichtblick-bak backup ~/code ~/Documents ~/Desktop ~/Nextcloud --skip-if-unchanged
        restic --password-file ~/.config/restic-pw --repo rclone:sb:lichtblick-bak forget --keep-daily 7 --keep-weekly 4 --keep-monthly 12 --prune
      '')
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
