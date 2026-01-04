{ config, pkgs, ... }: {
  imports = [
    (builtins.fetchTarball {
      # Pick a release version you are interested in and set its hash, e.g.
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/nixos-25.11/nixos-mailserver-nixos-25.11.tar.gz";
      # To get the sha256 of the nixos-mailserver tarball, we can use the nix-prefetch-url command:
      # release="nixos-25.11"; nix-prefetch-url "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/${release}/nixos-mailserver-${release}.tar.gz" --unpack
      sha256 = "16kanlk74xnj7xgmjsj7pahy31hlxqcbv76xnsg8qbh54b0hwxgq";
    })
  ];

  mailserver = {
    enable = true;
    stateVersion = 3;
    fqdn = "mail.treescape.pl";
    domains = [ "treescape.pl" ];

    # A list of all login accounts. To create the password hashes, use
    # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
    loginAccounts = {
      "ogrody@treescape.pl" = {
        hashedPassword = "$2b$05$ErrVd36QNHDiuvuKCdzMt.USra6nCRnisD0O1DQwY65nDTZhrSwPa";
        aliases = ["ogrody@treescape.pl"];
      };
      #"user2@example.com" = { ... };
    };

    # Use Let's Encrypt certificates. Note that this needs to set up a stripped
    # down nginx and opens port 80.
    certificateScheme = "acme-nginx";
  };
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "gawlikbar@gmail.com";
}
