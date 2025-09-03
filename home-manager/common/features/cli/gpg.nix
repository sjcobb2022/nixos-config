{
  pkgs,
  config,
  lib,
  ...
}: {
  # services.gpg-agent = {
  #   enable = true;
  #   enableSshSupport = true;
  #   pinentryPackage = pkgs.pinentry-tty;
  # };
  programs.gpg = {
    enable = true;

    # https://support.yubico.com/hc/en-us/articles/4819584884124-Resolving-GPG-s-CCID-conflicts
    scdaemonSettings = {
      disable-ccid = true;
    };

    publicKeys = [
      {
        source = ../../pgp.asc;
        trust = 5;
      }
    ];

    # https://github.com/drduh/config/blob/master/gpg.conf
    settings = {
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      charset = "utf-8";
      fixed-list-mode = true;
      no-comments = true;
      no-emit-version = true;
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      with-fingerprint = true;
      require-cross-certification = true;
      no-symkey-cache = true;
      use-agent = true;
      throw-keyids = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;

    # https://github.com/drduh/config/blob/master/gpg-agent.conf
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
    pinentry.package = pkgs.pinentry-curses;
    extraConfig = ''
      ttyname $GPG_TTY
    '';
  };

  # programs = let
  #   fixGpg =
  #     /* bash */
  #     ''
  #       gpgconf --launch gpg-agent
  #     '';
  # in {
  #   # Start gpg-agent if it's not running or tunneled in
  #   # SSH does not start it automatically, so this is needed to avoid having to use a gpg command at startup
  #   # https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
  #   bash.profileExtra = fixGpg;
  #   fish.loginShellInit = fixGpg;
  #   zsh.loginExtra = fixGpg;
  #   nushell.extraLogin = fixGpg;
  #
  #   gpg = {
  #     enable = true;
  #     settings = {
  #       trust-model = "tofu+pgp";
  #     };
  #     publicKeys = [
  #       {
  #         source = ../../pgp.asc;
  #         trust = 5;
  #       }
  #     ];
  #   };
  # };
  #
  # systemd.user.services = {
  #   # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
  #   # So that SSH config does not have to know the UID
  #   link-gnupg-sockets = {
  #     Unit = {
  #       Description = "link gnupg sockets from /run to /home";
  #     };
  #     Service = {
  #       Type = "oneshot";
  #       ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
  #       ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
  #       RemainAfterExit = true;
  #     };
  #     Install.WantedBy = ["default.target"];
  #   };
  # };
}
