# this module is the absolute bare minimum. also available on headless systems and small VMs
# TODO: REALLY!? The list is pretty big, postgres and emacs :D
{ config, lib, pkgs, systemName, ... }:
{
  home = {
    packages = with pkgs; [
      pkgs.coreutils
      pkgs.curl
      pkgs.dua
      pkgs.emacs-lsp-booster
      pkgs.eza
      pkgs.git
      pkgs.httpie
      pkgs.netcat-gnu
      pkgs.nix-direnv
      pkgs.nmap
      pkgs.postgresql
      pkgs.pv
      pkgs.rclone
      pkgs.restic
      pkgs.ripgrep
      pkgs.rsync
      pkgs.spaceship-prompt
      pkgs.speedtest-go
      pkgs.tree-sitter
      pkgs.unixtools.watch
      pkgs.vim
      pkgs.wget
      # markus below
      # CLI utils
      # age
      # bat
      # cloc
      # colordiff
      # entr
      # eza
      # fd
      # file
      # httpie
      # htop
      # iftop
      # inetutils
      # jq
      # mise
      # ncdu
      # # pdftk
      # pstree
      # pwgen
      # rclone
      # rsync
      # ripgrep
      # socat
      # tldr
      # tree
      # watch
      # wdiff
      # wget
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "Stefan Keidel";
    userEmail = "stefan.keidel@lichtblick.de";
    diff-so-fancy.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      merge = {
        ff = false;
      };
      pull = {
        rebase = true;
      };
    };
    signing = {
      signByDefault = false;
      format = "openpgp";
    };
  };
}
