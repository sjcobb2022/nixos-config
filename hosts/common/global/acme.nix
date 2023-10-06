{
  # Enable acme for usage with nginx vhosts
  security.acme = {
    defaults.email = "sam.cobb.2003@gmial.com";
    acceptTerms = true;
  };

  environment.persistence = {
    "/persist" = {
      directories = [
        "/var/lib/acme"
      ];
    };
  };
}
