_: {
  home = {
    persistence = {
      "/persist" = {
        directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".local/share/keyrings";
            mode = "0700";
          }
          {
            directory = ".config/sops/age";
            mode = "0700";
          }
        ];
      };
    };
  };
}
